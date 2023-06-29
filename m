Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6BD7422EE
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 11:09:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEneF-0004mt-Iy; Thu, 29 Jun 2023 05:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qEne4-0004du-QN; Thu, 29 Jun 2023 05:08:58 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qEne3-00017e-AD; Thu, 29 Jun 2023 05:08:56 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-262fa79e97fso221292a91.2; 
 Thu, 29 Jun 2023 02:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688029732; x=1690621732;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vL6DX9o1wVSena7skSRJbIaSB0I7VBx0PSyDJf5OPbk=;
 b=b3cCduB7h/2eXD1QdxiDVRR0G8Myyc4ePHWmrQPrvq2shvcK0TMWCstO5ztFhrjdh8
 dZnPGBJVndmbGYidIgqRoQMuYnKa6A5SdxmQqFgCpsIffkFJHOf4/GwtqWnFTrLmJbZi
 BKmGa0xp37L0eWidfSMwS4gHgm9jqopHLSyrteNVPcF2mQeFQUFWLvjZhvczFHTOmeKy
 gXQmfrIOIaVPIkQyPJ22n5KUjOdc85N+i8e7SAX6IxkUX6nH69QfzcT111kgElS8IeWC
 DGiVAoe0oxPD3CEDZ6/pd07jMM9K/EvVUG2sI6YCvBEzdWn0ahKMZQ8F3/3f1iHVMCDl
 YS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688029732; x=1690621732;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vL6DX9o1wVSena7skSRJbIaSB0I7VBx0PSyDJf5OPbk=;
 b=a5E4Qjliw9kuVHT7naTMgNci+IdBDhSFRC26N685a8bMQahTyy6MGpfxpfaUUy/Oeq
 8CHJSy7oq4+qtH0TkxmAr545+/C82t3HXs8f5zMk9MNdCtb4sK9sCFSiDg12wDTePe7P
 +7ERt5xZod5+KW/2bro0OTzUkNgvQk7s8o6E5DnjovuSftt6IqOSEtRUR/A4lpcJqrqZ
 Eue2DLay6oqwdMamizPyNfqKTi67vu99oddrf6l/KOgVjiDlbkONECwP6ck+Uz5vDLyJ
 PkIyGRMKOpdcLU1t+jHkE8N8rs8oXPLS6Z8qBq58O/eRdNsHkscIsiQ8xYN6W67XEW6h
 xa0Q==
X-Gm-Message-State: AC+VfDwviyxKjexySwrTv6jr1RunLOEPgjcuFl1XptUhYj4winnsCmAS
 qoaCJ6R4GqAXUeetM8xJfkE=
X-Google-Smtp-Source: ACHHUZ6yYKHZ2E8IU+cMMv99/+AHr7vcbyOCI0ztJhP1cgmeX2WvOOVL76nWm3phNw2vaooPv7ZRMg==
X-Received: by 2002:a17:90a:bd06:b0:263:8c2:6290 with SMTP id
 y6-20020a17090abd0600b0026308c26290mr7008195pjr.43.1688029731876; 
 Thu, 29 Jun 2023 02:08:51 -0700 (PDT)
Received: from localhost (203-219-179-91.tpgi.com.au. [203.219.179.91])
 by smtp.gmail.com with ESMTPSA id
 d7-20020a17090ad3c700b00262d9f4496bsm7729544pjw.6.2023.06.29.02.08.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 02:08:51 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Jun 2023 19:08:45 +1000
Message-Id: <CTP0LIDK25K1.3CPXDYZXWKPDJ@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "David Gibson" <david@gibson.dropbear.id.au>, "Greg Kurz" <groug@kaod.org>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "Paolo Bonzini"
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 3/4] target/ppc: Make checkstop actually stop the system
X-Mailer: aerc 0.15.2
References: <20230627134644.260663-1-npiggin@gmail.com>
 <20230627134644.260663-4-npiggin@gmail.com>
 <ba3833be-1b0d-3814-c4de-79375264eb4e@linaro.org>
In-Reply-To: <ba3833be-1b0d-3814-c4de-79375264eb4e@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed Jun 28, 2023 at 7:33 PM AEST, Richard Henderson wrote:
> On 6/27/23 15:46, Nicholas Piggin wrote:
> > +    vm_stop(RUN_STATE_GUEST_PANICKED);
>
> Calling qemu_system_guest_panicked(NULL) seems to be more correct.

I'll have a look.

> Though I'm not really sure the difference from cpu_abort(), which would a=
lso care for=20
> dumping cpu state.

cpu_abort() just kills qemu, so you can't inspect anything. This way
e.g., gdb server and monitor stay up. Seems like you can even re-start
it(?). This is close to what we want short of models for BMC and host
debug logic.

Thanks,
Nick

