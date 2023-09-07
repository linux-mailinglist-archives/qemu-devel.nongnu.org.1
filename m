Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CD7797261
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 14:38:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEGl-00026r-6A; Thu, 07 Sep 2023 08:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qeEGj-00026f-18
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 08:37:57 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qeEGf-00032b-DY
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 08:37:56 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3aa139a0ab2so605728b6e.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 05:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694090271; x=1694695071;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OxZECmNJzLrjVrY3MBHxgtzSD0rX3BAFoAvCwyZ8YAo=;
 b=BiTLctoOcmzWEL0C767YSckA49s9pU7fvOEPjdxn2JF2AOY4jVS9v30cwoD5gME4js
 6gOh2CPlEXT4vKcL2BaSx72eQXusP2DbINjX4N28bMa8ZYKCghSgDQn16N1qnfw7apDK
 fQVSrLIgX1cVJGvv9NHP2yVfbTBD2x2ynXXXTayib/mnKCDdrct5Cci2wYoAwTnnqPTv
 Y8AVOFBuE5RuxN3Jl8vgheh8MG7HqSK54gau7sXuT7ODOsAHuMdtoCXorwRGZC8YW+El
 D1BuZYHGXTMpeqk9wMLpwOAdxtVPEHmpCtjmnn4GMzyvcxpGcIu4s2TBvnyU9qywjpBf
 ZKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694090271; x=1694695071;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OxZECmNJzLrjVrY3MBHxgtzSD0rX3BAFoAvCwyZ8YAo=;
 b=Xm5YfxYxY7Ioq+IYAiI7iVcNibugxVtMsoA4FbvZ6WGyb/unJqlXgEnaivV8QAIk2k
 sGyolWbl2jaBCRWwnnlTxScpuFyjpvh35Jqb1JK84bGlPggjeeMWhgfn3rW2IZ5X7hyy
 xRSUDV9N3+ZzUq6pETaEfg5OuupE14szD7Zs0/a+U2IQWXKn446b/IGrj2HUkDznV6d1
 hIHGsenitS/dgAMoRBjIYS+JBDTVe6JFnKh3lAV9LiqIcqFbNn27XMFACqFSPYuP4Wph
 MnV9CEMpUZkDhG4Z2KQWdyfTpu/JdUE58HgkDS4kbU3BDrAu3hzEOuFXCL4i6jUIPwRN
 /feg==
X-Gm-Message-State: AOJu0YxBF6vETPTn28Gt+0uTcbYbywhdr4sNJLCMFtpAo55oTRPpTJma
 9C7V4KdJpoH5/aY758m6kijV+Y4Vwk1bwMxXvGM11A==
X-Google-Smtp-Source: AGHT+IENcDKx3InjAfWiyyBaRgr0kSMEK2KBiC8l9J/IsfMsmGQ614qnNG1+DHRH83du5iAVPhU38mk4bzWolEd0t7k=
X-Received: by 2002:a54:4485:0:b0:3a7:9837:7148 with SMTP id
 v5-20020a544485000000b003a798377148mr17219350oiv.58.1694090271633; Thu, 07
 Sep 2023 05:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230823092905.2259418-1-mnissler@rivosinc.com>
 <20230823092905.2259418-2-mnissler@rivosinc.com> <ZOZDQVgboMaiZ4x6@x1n>
 <CAGNS4TY2-scz3pu16tUF1bA-FEk+pe86QsgjW8L=qjidw5TqOQ@mail.gmail.com>
 <ZOZx7vMqFRfaIwSp@x1n> <20230824133245.GA1412804@fedora>
 <87edjixb6n.fsf@pond.sub.org>
 <CAGNS4TaEL1CapL3NoM4XYVMLOH-heOs=2WHMLHNEz072fcxNfw@mail.gmail.com>
 <ZPcxD+lqtt8PFwCl@x1n>
In-Reply-To: <ZPcxD+lqtt8PFwCl@x1n>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Thu, 7 Sep 2023 14:37:40 +0200
Message-ID: <CAGNS4TbYk=Xj0hnD6EVipSxZ3VSa9dHJvGV55hzMMsEXrxMgMw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] softmmu: Support concurrent bounce buffers
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 john.levon@nutanix.com, Jagannathan Raman <jag.raman@oracle.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=mnissler@rivosinc.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Sep 5, 2023 at 3:45=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Sep 05, 2023 at 09:38:39AM +0200, Mattias Nissler wrote:
> > It would be nice to use a property on the device that originates the
> > DMA operation to configure this. However, I don't see how to do this
> > in a reasonable way without bigger changes: A typical call path is
> > pci_dma_map -> dma_memory_map -> address_space_map. While pci_dma_map
> > has a PCIDevice*, address_space_map only receives the AddressSpace*.
> > So, we'd probably have to pass through a new QObject parameter to
> > address_space_map that indicates the originator and pass that through?
> > Or is there a better alternative to supply context information to
> > address_space map? Let me know if any of these approaches sound
> > appropriate and I'll be happy to explore them further.
>
> Should be possible to do. The pci address space is not shared but
> per-device by default (even if there is no vIOMMU intervention).  See
> do_pci_register_device():
>
>     address_space_init(&pci_dev->bus_master_as,
>                        &pci_dev->bus_master_container_region, pci_dev->na=
me);

Ah, thanks for that hint! This works, and it probably even makes more
sense to treat bounce buffering as a concept tied to AddressSpace
rather than a global thing.

I'll send an updated series shortly, with the configuration parameter
attached to the PCI device, so it can be specified as a -device option
on the command line. In that light, I decided to keep the default at
4096 bytes though, since we now have the ability for each device model
to choose its default independently.

