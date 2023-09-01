Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FDE78FF38
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 16:31:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc5Az-0005c8-6C; Fri, 01 Sep 2023 10:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1qc5As-0005Uy-BP
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 10:31:05 -0400
Received: from esa3.hc2706-39.iphmx.com ([68.232.154.118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1qc5Ao-0004sG-Ni
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 10:31:01 -0400
X-IronPort-RemoteIP: 209.85.160.199
X-IronPort-MID: 300870816
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:ki5s9agCgoa3MlXrWe3pkg8RX1612BIKZh0ujC45NGQN5FlHY01je
 htvWGCBbKyLamqmf9x1PIXn/U4AucDVmtBhTQNsqCEyRXwW8JqUDtmndXv9bniYRiHhoOOLz
 Cm8hv3odp1coqr0/0/1WlTZhSAgk/rOHvykU7Ss1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 Jb5rta31GWNglaYCUpKrfrZwP9TlK6q4mhA7wRnPaojUGL2zBH5MrpOfcldEFOlGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiM+t5qK23CulQRrukoPD8fwXG8M49m/c3Gd/
 /0W3XC4YV9B0qQhA43xWTEBe811FfQuFLMqvRFTGCFcpqHLWyKE/hlgMK05FYc4xctZWXNXz
 95GCG4AQBasqu2UzK3uH4GAhux7RCXqFIYWu3Ul1C2ASPh/EMGFTKLN6ttVmjw3g6iiH96EP
 5tfOWcpNUqYJUQeaz/7C7pn9AusrnD7YztUsnqfuOw673W7IAlZi+C1YIWNKoXULSlTtl+zo
 VjLpzr/PhcDac7Y+CXU+yynmOCayEsXX6pXTtVU7MVCmVCW2ykfBQMbUXO9pv+2jFP4XMhQQ
 3H44QIrpKk2sVW3F5zzBkzp5nGDuREYVpxbFOhSBByx95c4Kj2xXgAsJgOtovR/7ZReqeACv
 rNRo+7UOA==
IronPort-HdrOrdr: A9a23:jJV+c62nOJKMk9rAbKIvrAqjBG4kLtp133Aq2lEZdPU1SL3iqy
 nKpp8mPHDP5gr5NEtMpTnCAtjlfZqkz/9ICNAqXYtKPzOW2ldATrsSlbcKqgeIc0fDH4hmpM
 JdmsNFZ+EYY2IXsS+02njeLz+M+qjgzIm4wc3l5zNGSwVybqFp6A10TjycDlZ9SGB9dPkE/d
 6nl7N6mwY=
X-Talos-CUID: 9a23:kI38O2Cjn/k0QOf6EyNHy2M6QtI8SF+D7CndDUmXJGlLRKLAHA==
X-Talos-MUID: 9a23:fjAscQmxhXTAACJOrfg8dnp7H8BS7vzwDnwLiMgU/PibZCUuMCmS2WE=
Received: from mail-qt1-f199.google.com ([209.85.160.199])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Sep 2023 10:30:14 -0400
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4131d4bc82dso20272121cf.3
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 07:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1693578613; x=1694183413; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=515CeJ61FpuhoUoyzuuZKdSyYpWMrmeAeHKCHYohlC8=;
 b=Sf6RKeOW8nA7Ly7OMr/pDuF2Eob9/h64boVnMGisuE0Dq71uIU7FD5hiIJyWlvjqHA
 KRfYTKVrqeX7XN1uNbwWpaTcREcA7Eel7Y3AjYIZhr9aw+EDnwfInFRipnAF5v5GHHVb
 a1jS4RQUa1DiaIdTppi4C+H/M6lo97MgrzsP15qlf5aa/hroshYsdHUKx6/yqrmYv0Vd
 pui89mA4h4PUyaEwtcx/yTksU0c28Tz88vkvSolZxmL/XlXmy/uxQcfdI1d9NvQICNIv
 zYT/6iJjJdMy44ilsjMLhLvwgs1vI6/UvgAJm1hVSF3+lHu4qKD0aIEhKnYAe0om2C3t
 V6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693578613; x=1694183413;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=515CeJ61FpuhoUoyzuuZKdSyYpWMrmeAeHKCHYohlC8=;
 b=ESjxxlg7nSuhjFN4h9DqvdPqv19GSNNDpboz8i2dk1rfp1bc4MMsoe4FfqlW9BSbTr
 JvP72CTdeP7VNgQC3DMLM1qMm+TkTXf00YRenFNpRsZBrINHoAi6Wb3oL2mm1QYLgiMb
 kcf2zkS/cGSGHopEnSPBil8wP1JMHTvDvoJi8PiYH/46bSKmdxEmzdvyj4RBO5K2tvh1
 Xd/FgbPLJDjlC3siauZC8SzX4jWJUBz2sjyBUbMUooPoCrcVWjHrJayWoknjyesCMH4T
 kzd8Vrpu/q1IGlADGv28eU7tPlc0Zbw1rqaHnnbVOA9GRAlpnrdeOwDgzbJUYHguDink
 cxSw==
X-Gm-Message-State: AOJu0Yy7caG9nLlnlEeR8/+dSP8kkXX1OAcwZSvbCDBgiI9AKaQy31P1
 RVzIchgOB6Ujhq7J6BMn2SmdDMmhvEItBkm52ganx92aN9iJkDwWxyHwz1aMiqgK0VKl6WgjDHi
 i2B9p53nlbztY6Z+c1h3GrK27MB28Bg==
X-Received: by 2002:ac8:7dd0:0:b0:410:3405:7399 with SMTP id
 c16-20020ac87dd0000000b0041034057399mr2593556qte.44.1693578613391; 
 Fri, 01 Sep 2023 07:30:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhM955dgtOtfRnv8y5u/Q7g0CBYnXeVQrYI2fqHlr5i6yjmE/rKkzoArsfQ8uCHllQmU791w==
X-Received: by 2002:ac8:7dd0:0:b0:410:3405:7399 with SMTP id
 c16-20020ac87dd0000000b0041034057399mr2593531qte.44.1693578613044; 
 Fri, 01 Sep 2023 07:30:13 -0700 (PDT)
Received: from mozz.bu.edu (mozz.bu.edu. [128.197.127.33])
 by smtp.gmail.com with ESMTPSA id
 z22-20020ac875d6000000b00405d7c1a4b0sm1483859qtq.15.2023.09.01.07.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 07:30:12 -0700 (PDT)
Date: Fri, 1 Sep 2023 10:30:09 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Lev Kujawski <lkujaw@mailbox.org>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] hw/ide/core.c (cmd_read_native_max): Avoid limited
 device parameters
Message-ID: <20230901143009.xlxekntmcrivuof6@mozz.bu.edu>
References: <20221010085229.2431276-1-lkujaw@mailbox.org>
 <CAFn=p-aHLW0kmOLUw6OJFYwY8a24bmb4grFYL3XE_ircmcTbJQ@mail.gmail.com>
 <877cxs2xy9.fsf@bromine.uucp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cxs2xy9.fsf@bromine.uucp>
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=68.232.154.118; envelope-from=alxndr@bu.edu;
 helo=esa3.hc2706-39.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 230112 0412, Lev Kujawski wrote:
> 
> John Snow writes:
> 
> > On Mon, Oct 10, 2022 at 4:52 AM Lev Kujawski <lkujaw@mailbox.org> wrote:
> >>
> >> Always use the native CHS device parameters for the ATA commands READ
> >> NATIVE MAX ADDRESS and READ NATIVE MAX ADDRESS EXT, not those limited
> >> by the ATA command INITIALIZE_DEVICE_PARAMETERS (introduced in patch
> >> 176e4961, hw/ide/core.c: Implement ATA INITIALIZE_DEVICE_PARAMETERS
> >> command, 2022-07-07.)
> >>
> >> As stated by the ATA/ATAPI specification, "[t]he native maximum is the
> >> highest address accepted by the device in the factory default
> >> condition."  Therefore this patch substitutes the native values in
> >> drive_heads and drive_sectors before calling ide_set_sector().
> >>
> >> One consequence of the prior behavior was that setting zero sectors
> >> per track could lead to an FPE within ide_set_sector().  Thanks to
> >> Alexander Bulekov for reporting this issue.
> >>
> >> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1243
> >> Signed-off-by: Lev Kujawski <lkujaw@mailbox.org>
> >
> > Does this need attention?
> >
> > --js
> >
> 
> Hi John,
> 
> This patch needs to be merged to mitigate issue 1243, which is still
> present within QEMU master as of aa96ab7c9d.
> 
> Thanks, Lev
> 

Ping. oss-fuzz re-discovered this bug.

