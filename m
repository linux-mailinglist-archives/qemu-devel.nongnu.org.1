Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EEE7B72A2
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 22:43:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnmDh-000621-VE; Tue, 03 Oct 2023 16:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1qnmDf-00061j-HE; Tue, 03 Oct 2023 16:42:15 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1qnmDc-00040G-Tn; Tue, 03 Oct 2023 16:42:15 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2bfed7c4e6dso15579781fa.1; 
 Tue, 03 Oct 2023 13:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696365729; x=1696970529;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:dkim-signature:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z5oV+jPgSLwklVniMdiKPTlFkWAxtqbhJGZPCb66U44=;
 b=MYutURvmH0vCMtefyZIKh2a2c/kJlaAmL20kZ9led2BQup3waFdoaTrjvKfJxw+19J
 29UXzZAh15eNR8L8drJF0LwW+lC1ii4WSHCBwBrhFxiyJQozXkMhvYBTZJYM6m1fCvVc
 woxPDZBw5cT8QK5ZVoHRl1elOG7LUsqNsRwr80t3UW/SH2p6RR+wHaTeOvh272WtCdzQ
 1JYG3iiuGc9agMqetOJPhkNg51DW6jTuzpDEK3alvE6QtofORnDUyFf2diSN0s6tho5J
 3bEwsToC/oNEcZgI4+JHd6FeesnLG0j9ttePODosuctjXvaToPexjLR971BkYLU4jcZX
 ThXw==
X-Gm-Message-State: AOJu0YzgbD/GuQdn4IXxezmIQXYzzUPOH0gkCOFx0L/0yTP/vp1gHBto
 352YtU67Edxxs6lURXhOqS0kOxWmXdPtcvbx
X-Google-Smtp-Source: AGHT+IEZWq+88DML9eVDReizu66XMMX1z/dyjtmuxq12hSC4F3clrtAZIMQOQejOM60yeOWfcyZggw==
X-Received: by 2002:a2e:6a10:0:b0:2bc:efa4:2c32 with SMTP id
 f16-20020a2e6a10000000b002bcefa42c32mr270496ljc.37.1696365728915; 
 Tue, 03 Oct 2023 13:42:08 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.240.245]) by smtp.gmail.com with ESMTPSA id
 u26-20020a2e855a000000b002ba586d27a2sm374711ljj.26.2023.10.03.13.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 13:42:08 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id B565AB9F1; Tue,  3 Oct 2023 22:42:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1696365727; bh=qSpALkf6fr+sgcNjdaxxx4Qbb7YY/1JzBIboUmbeGWw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Urqiunm+/vUSlCyPUEhrH2jNbuw9BgT1GEHH6mPj74Wu+z7hD6bymdMrzXU9fNSj2
 JAQEwWwUwcGSA4SJGXaV/23d9GfxNVod5Tq939p0Qsf5cM4yJAOcnmY2ixZwEjukAW
 JZr9IhytZowSb9tGqAK4Q/g+e745gtQoFNfNfXvY=
Received: from x1-carbon (OpenWrt.lan [192.168.1.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id 1E49FB8DD;
 Tue,  3 Oct 2023 22:41:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1696365709; bh=qSpALkf6fr+sgcNjdaxxx4Qbb7YY/1JzBIboUmbeGWw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=er/23/9m5AzWCroNENpAmVAbPu7TJ1jkJMs1IZ4xCtJU1v+g6qVAVbA/jdPh905hW
 Ql6dhSz/voDmtLqDK2kRD6OApJTWV84qf3ckHKzRlo0hCds/zRzY2LcQ8DFYI53AEG
 JPFr6RjAQHF5JQkAYbZISDaK4CWyL7ZdEC+Q6Vqk=
Date: Tue, 3 Oct 2023 22:41:44 +0200
From: Niklas Cassel <nks@flawful.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Damien Le Moal <dlemoal@kernel.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Ard Biesheuvel <ardb+tianocore@kernel.org>
Subject: Re: FreeBSD 13.2 installer does not see AHCI devices on
 aarch64/sbsa-ref and x86-64/q35
Message-ID: <ZRx8iLkWE5fwLOpE@x1-carbon>
References: <b7e00b36-2ac8-44fa-9847-b2025ebe05f6@linaro.org>
 <F1D854EB-9C6F-4A54-BAA9-D75C40DBE86F@flawful.org>
 <a6cc110d-132e-b3f3-0b64-368bcb5c31a9@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6cc110d-132e-b3f3-0b64-368bcb5c31a9@tls.msk.ru>
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=nks.gnu@gmail.com; helo=mail-lj1-x236.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Oct 03, 2023 at 08:11:39PM +0300, Michael Tokarev wrote:
> 26.09.2023 15:05, Niklas Cassel:
> > Hello Marcin,
> > 
> > I will have a look at this.
> 
> Hi Marcin, Hi Niklas!
> 
> Niklas, I remember asking you if the whole thing is okay for the -stable,
> and you was a bit unsure about it :)  Regardless, I picked the changes
> up for -stable. I don't think it was anyone's fault though, - after all,
> I guess, without the change being in -stable, we'd know about this issue
> in some distant future instead of now :)
> 
> I'm planning to release 8.1.2 soon, with freeze being at Oct-14.  It'd
> be really great if we can include a fix for this both in master and in
> 8.1.2 (8.1.2 should have a long-awaited fix for a quite serious long-
> standing issue in 8.1).
> 
> Were you able to take a look at what's going on here?  I wish I were
> able to help here but I know right to nothing about ahci emulation..

I was away on a conference all last week, so I didn't have much time to
look at this yet. I will debug the problem this week.

From at quick look at Marcin logs:
ahcich0: Poll timeout on slot 1 port 0
ahcich0: is 00000000 cs 00000002 ss 00000000 rs 00000002 tfd 170 serr 00000000 cmd 0000c017

This log seems to come from:
http://fxr.watson.org/fxr/source/dev/ahci/ahci.c?v=FREEBSD-13-STABLE#L1795

Looking at the print "cs 00000002" means PxCI: 0x2.
So PxCI is never cleared.

I will need to run FreeBSD so I can see which command it is that never gets
PxCI cleared.

NCQ commands will always clear PxCI in process_ncq_command().
Non-NCQ commands will always clear PxCI in ahci_clear_cmd_issue().

From a quick glance, the only time we do not clear PxCI is if we receive
a FIS that we do not handle (trace_handle_cmd_unhandled_fis()).
Will try to see exactly which FIS FreeBSD is sending tomorrow.

(Perhaps we should simply clear PxCI for these FISes that we do not handle...
Or at least make sure that we set ERR_STAT in PxTFD.)


Kind regards,
Niklas


