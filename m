Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D457EEDFB
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 09:59:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3ufo-0007Sw-5O; Fri, 17 Nov 2023 03:58:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1r3ufk-0007So-7r
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 03:57:56 -0500
Received: from esa2.hc2706-39.iphmx.com ([216.71.152.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1r3ufi-0003OP-Ak
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 03:57:56 -0500
X-CSE-ConnectionGUID: aVGF6Ub1QOSAchIrEmP4aA==
X-CSE-MsgGUID: NTmB0TwXQqi/AdS0w/9l2Q==
X-IronPort-RemoteIP: 209.85.128.199
X-IronPort-MID: 320622272
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:CgvOLKjrZelSAhZG/1PCaCw9X1613hIKZh0ujC45NGQN5FlHY01je
 htvXzjTaauOajanL9slb9mz90IOvZ+BnIUwTwJt/H1nRCoW8JqUDtmndXv9bniYRiHhoOOLz
 Cm8hv3odp1coqr0/0/1WlTZhSAhk/nOHvylULKs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 Jb5rta31GWNglaYCUpKrfrfwP9TlK6q4mhB5wVhPakjUGL2zBH5MrpOfcldEFOlGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiM+t5qK23CulQRrukoPD8fwXG8M49m/c3Gd/
 /0W3XC4YV9B0qQhA43xWTEBe811FfQuFLMqvRFTGCFcpqHLWyKE/hlgMK05FYQm1cgpPGsXz
 NsjATsNTwqugtrqyZvuH4GAhux7RCXqFIYWu3Ul3C6ASPh/EMGFTKLN6ttVmjw3g6iiH96EP
 5tfOWcpNU6QJUQeaz/7C7pn9AusrnD7YztUsnqfuOw673W7IAlZi+K1boCPIIPQLSlTtmCko
 0iew3vJOwgbc/WT8mKatSOo3NaayEsXX6pXTtVU7MVCmVCW2ykfBQMbUXO9pv+2jFP4XMhQQ
 3H44QIrpKk2sV20F5zzBkzp5nGDuREYVpxbFOhSBByx95c4Kj2xXgAsJgOtovR/3CPqbVTGD
 mO0ou4=
IronPort-HdrOrdr: A9a23:Yc8fiqraBjjssl7vZsLxXrMaV5oWeYIsimQD101hICG9E/bo8v
 xG+c5xvyMc5wx8ZJhNo7+90dC7MArhHP1OkOss1NWZPDUO0VHAROxfBO3ZrQEIcBeOldK1u5
 0AT0EwMqyWMbE/t7eD3OGEe+xQpOVu0siT9IHj80s=
X-Talos-CUID: 9a23:7qtL62167tKz1JD2fDKgV7xfE/4KXCPgxi7pBHSRAmZIUpCQcQOZ0fYx
X-Talos-MUID: 9a23:54zF5Ql5oKIYJw9PDRZhdnpECMJCu5ixOHkUkNIvt/LcKmshP22k2WE=
Received: from mail-yw1-f199.google.com ([209.85.128.199])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 17 Nov 2023 03:57:44 -0500
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-5c7045e972dso9216627b3.0
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 00:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1700211464; x=1700816264; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WtSgz2UY0JL3yqV+2APu64VGNbifb+luBZIpK7iPKa4=;
 b=J+krvKq15Z8SffuRDwX5gk0WAYsknUYYcVMsvk8OFCEgi7HsYPThvdJYK99WZYqTsA
 zhnyCN4vD38/lXw4kRr3qhL1HgzOo+/Uvn6dkRUjnMB7zXOArzrAQ/gS8MaUb+VLGoq0
 boc+CvR9GSSOsQxAMP7zTlIQvfiziL5S2A/sVcZ4a8L8oulRTNy4DataxmekS5BlnTBS
 iny6iROKMqS83bo0a6TO4mm5E6J7hjTZxvsos6LilCVOtzx3K+p7cSps74Mpl19RA8en
 LFUCl5CC3kBqaqbbrWYKSrGFPprDSV5QAOKTLvyqW+QZyqCr9KSdlzme4Iye8Q+y/ksS
 ISnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700211464; x=1700816264;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WtSgz2UY0JL3yqV+2APu64VGNbifb+luBZIpK7iPKa4=;
 b=TF5up7HJ2HVhAxmqbi3CPIdv25LaDL+iOAq9n6CYmJkf4M5DvTJWKL4pNOzzOqucV1
 lI600LVQbTBaYoEKylWsuKBj0guqTYkJOjQYB18wn04GYV7izX8z8iKKY1fyO0MgIjeD
 NuBR24fm7qqtt/r2zQaupdB3xLOAx3qSdkujnvtRxuCxX7hbi8Zqq8ei+ZhbROyB1Wgg
 dQAklqGLEe3nc4HOc0ugr0Z6DS+BsE58NpawkMb8zZzQShhVNIvtJLEThnnoUNqPrN/J
 aVNvmUrAHCq1ZvVP/C6zJWiit7sooTpZtSSId0Ni1dSL5IefTUOncqn92HYT/xVUMkGR
 ddGg==
X-Gm-Message-State: AOJu0YwtzyUDa+tiEa3roBGLswVHV8xlGiQL34xTNj753do6EaFgNdzD
 B8lULga3YGvG37HtzoBAchrOxZ9MDhboUrSmSxL+BVu71vrRhwcNATRvj70pTgoXftRaxy4fbMv
 /RVdob34UadJLuHdmp8fW1E91CWzNHA==
X-Received: by 2002:a81:9a08:0:b0:5c1:1a71:4706 with SMTP id
 r8-20020a819a08000000b005c11a714706mr18758900ywg.42.1700211464027; 
 Fri, 17 Nov 2023 00:57:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvxLHCnfXI3mstMm2JF0aw2SqAzSNcjFL8QkYlOo16/UMOCkwhwMpyCw+DrEriO7Vaqpv3Qw==
X-Received: by 2002:a81:9a08:0:b0:5c1:1a71:4706 with SMTP id
 r8-20020a819a08000000b005c11a714706mr18758890ywg.42.1700211463809; 
 Fri, 17 Nov 2023 00:57:43 -0800 (PST)
Received: from mozz.bu.edu (mozz.bu.edu. [128.197.127.33])
 by smtp.gmail.com with ESMTPSA id
 e81-20020a816954000000b0059b2be24f88sm372644ywc.143.2023.11.17.00.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 00:57:43 -0800 (PST)
Date: Fri, 17 Nov 2023 03:57:36 -0500
From: Alexander Bulekov <alxndr@bu.edu>
To: Brian Cain <bcain@quicinc.com>
Cc: "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "megele@bu.edu" <megele@bu.edu>,
 Elia Geretto <egeretto@qti.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: QEMU snapshotting
Message-ID: <20231117085736.4rxdeoy4opl6lpnl@mozz.bu.edu>
References: <SN6PR02MB4205853A81107ACEDB0A3847B8B1A@SN6PR02MB4205.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4205853A81107ACEDB0A3847B8B1A@SN6PR02MB4205.namprd02.prod.outlook.com>
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=216.71.152.49; envelope-from=alxndr@bu.edu;
 helo=esa2.hc2706-39.iphmx.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 231115 1522, Brian Cain wrote:
> Alexander, Bandan, Paolo, Stefan, Manuel,
> 
> Hi, I'm Brian and I maintain the Hexagon arch for QEMU.  Elia, a security researcher at Qualcomm is exploring ways to fuzz some hexagon OS kernel with QEMU and in particular leveraging snapshotting, inspired by your research and more.  I'm not an expert on the details, but I'd like to make an introduction and see if there's an opportunity for us to learn from one another.  Maybe we can have a call to kick things off?
> 

Hi Brian, Elia,
Sounds interesting! Happy to hop on a call to discuss. Mornings (EST)
tend to work best for me.
-Alex

> -Brian

