Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CDF7FAFC9
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 02:51:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7nFZ-0001Ts-OG; Mon, 27 Nov 2023 20:50:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r7nFR-0001Ni-1b; Mon, 27 Nov 2023 20:50:49 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r7nFP-0006c1-0H; Mon, 27 Nov 2023 20:50:48 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3b3f55e1bbbso3266479b6e.2; 
 Mon, 27 Nov 2023 17:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701136245; x=1701741045; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zOIt79P3IRT5HGzhrYTMgU+7FB+E/U/MDKziaGb5GIo=;
 b=Eo2BT9GYzSj0UGHd0zDI29bFO5f290dh+8lXKuid2ogj0GvJeHA90RFNQ+tlWs0xgy
 aPK1HcnfU8Zh6xL5Yn01GyRk4aDD5da8o6sBLwNjIRDI4cWiZ17t6pkDA00VCLqtzQLO
 eLeqqMeA5ROF5ycSbhv6YT7jsiAaeTh1tdjkp7MBllryXhsBeOojiwQY778L69f4hhjJ
 KEFeBChnS8ehTEW4cY0a9wFKf3U7aB+40MKWk7f1V4MhV4wUXqkztYrtD2JXeIRpJG/S
 llqCOuhXBwxaTqCt4WPMiOBMhFkWypZKr6kRz2xKXmuMMBqu3h42uz1+Lw972nBVlfsH
 Rk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701136245; x=1701741045;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zOIt79P3IRT5HGzhrYTMgU+7FB+E/U/MDKziaGb5GIo=;
 b=mZb4v9BBe644uImzqhDg13KrP7qs9fgFwuPhDl2T1Ko9u3aUo3gHJH2EXXQ/n+4GQP
 XIwBhXxRybzUTP+o20xV9FpOHGqamZcronG6exvkxRpOrLWN2e4GtrdFKB77vWvmR9ZK
 M12GmsqbBfgGrKrR8EVRdIAHylAneBdl5KhyctXz0JGP//rWlix/fjjz2kukK/NDuq55
 uCJzaIkzcpjzJvn52U24PuIaKpCmhWP0PbqmN9UYCy0cpUsRNs/XB1WlJNL6YpCOwiYs
 3TsRv1SywLAhJswuxQ1ivTQvcat5yrCfMYG0PBSJ2B2BxJ1RDfbOATmY6+Gc6Lj7MKTK
 6BUg==
X-Gm-Message-State: AOJu0Yz9k/StDXCU/l8hu8Cv868r+URF2Lt2ujHw1nTuw90q1t6GnICJ
 qZMLFEBDymh/SwkMxr6PrLY=
X-Google-Smtp-Source: AGHT+IGM2ojYtpPfPcXMV6yKV7eEKyGEShA8GQKHDpfX4rnk2BH+bZ9aqGhFSCoeiUvRByT+UhokuA==
X-Received: by 2002:a05:6870:eca4:b0:1f9:f532:49c6 with SMTP id
 eo36-20020a056870eca400b001f9f53249c6mr16007021oab.20.1701136245199; 
 Mon, 27 Nov 2023 17:50:45 -0800 (PST)
Received: from localhost (121-44-66-27.tpgi.com.au. [121.44.66.27])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a056a0002c300b006cbb83adc1bsm7831220pft.44.2023.11.27.17.50.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Nov 2023 17:50:44 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Nov 2023 11:50:39 +1000
Message-Id: <CXA2GVQCIAHR.2JI0TNI5W06UD@wheely>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "David Gibson" <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 0/4] Add BHRB Facility Support
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Miles Glenn" <milesg@linux.vnet.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230925174351.617891-1-milesg@linux.vnet.ibm.com>
 <CWBNQ9QDEYH8.3QL9E2V4ZF26G@wheely>
 <66558e7df3b0eadece637f452bfbf7add72955eb.camel@linux.vnet.ibm.com>
 <c39ad84ee405d3539b40db34f920dc2879a940b4.camel@linux.vnet.ibm.com>
In-Reply-To: <c39ad84ee405d3539b40db34f920dc2879a940b4.camel@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x22c.google.com
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

On Tue Nov 28, 2023 at 6:51 AM AEST, Miles Glenn wrote:
> On Wed, 2023-10-18 at 10:59 -0500, Miles Glenn wrote:
> > On Thu, 2023-10-19 at 01:06 +1000, Nicholas Piggin wrote:
> > > On Tue Sep 26, 2023 at 3:43 AM AEST, Glenn Miles wrote:
> > > > This is a series of patches for adding support for the Branch
> > > > History
> > > > Rolling Buffer (BHRB) facility.  This was added to the Power ISA
> > > > starting with version 2.07.  Changes were subsequently made in
> > > > version
> > > > 3.1 to limit BHRB recording to instructions run in problem state
> > > > only
> > > > and to add a control bit to disable recording (MMCRA[BHRBRD]).
> > > >=20
> > > > Version 3 of this series disables branch recording on P8 and P9
> > > > due
> > > > to a drop in performance caused by recording branches outside of
> > > > problem state.
> > >=20
> > > Thanks for these, they all look good to me.
> > >=20
> > > With P10 CPU, Linux perf branch recording appears to work with this
> > > series, and I confirmed that Linux does disable BHRB in MMCRA at
> > > boot, so it should not take the performance hit.
> > >=20
> > > It had a couple of compile bugs, no matter I fixed them, but I
> > > often
> > > trip overppc32 and user-mode when working on TCG too, so building
> > > with --target-list including ppc64-softmmu,ppc-softmmu,
> > > ppc64-linux-user,ppc64le-linux-user,ppc-linux-user is good to catch
> > > those.
> > >=20
> > > Thanks,
> > > Nick
> > >=20
> >=20
> > Thanks, Nick.  I'll have to remember that for next time!
> >=20
> > Glenn
> >=20
>
> Hi Nick,
>
> Is there anything else you need me to do for this series to be merged?

Hey Glenn,

No, sorry I just missed this cycle. I have it queued up, it'll have to
go in after 8.2 release.

Thanks,
Nick

