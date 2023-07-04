Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AAC746D43
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 11:24:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGcH6-0005qP-Gg; Tue, 04 Jul 2023 05:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1qGcGp-0005f5-KY
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 05:24:29 -0400
Received: from esa2.hc2706-39.iphmx.com ([216.71.152.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1qGcGn-0004zt-RM
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 05:24:27 -0400
X-IronPort-RemoteIP: 209.85.128.197
X-IronPort-MID: 289015434
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:T4DOm6hlM1aDBZTA1TR4vwmDX1613hIKZh0ujC45NGQN5FlHY01je
 htvWGnXbPaLZmWmLtF1aoix8E0CvMLczN8wTlBr/39mRiwW8JqUDtmndXv9bniYRiHhoOOLz
 Cm8hv3odp1coqr0/0/1WlTZhSAgk/rOHvykU7Ss1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 Jb5rta31GWNglaYCUpKrfrawP9TlK6q4mhA4QRiPaojUGL2zBH5MrpOfcldEFOlGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiM+t5qK23CulQRrukoPD8fwXG8M49m/c3Gd/
 /0W3XC4YV9B0qQhA43xWTEBe811FfQuFLMqvRFTGCFcpqHLWyKE/hlgMK05FdYc+8l2Dntxy
 f4FKzxcbw6vityuzpvuH4GAhux7RCXqFIYWu3Ul3C6ASPh/EM+FTKLN6ttVmjw3g6iiH96EP
 5tfOWcpNU6QJUQeZT/7C7pn9AusrnD7YztUsnqfuOw673W7IAlZiui8aIOIJofWLSlTtl3Ii
 yHaxjXnOBhEH+2i6TGG7nm3u+CayEsXX6pXTtVU7MVCmVCW2ykfBQMbUXO9pv+2jFP4XMhQQ
 3H44QIrpKk2sV20F5zzBkzn5nGDuREYVpxbFOhSBByx95c4Kj2xXgAsJgOtovR83CPqbVTGD
 mO0ou4=
IronPort-HdrOrdr: A9a23:tvSri6phO8vvcOsMqxvvzEkaV5rneYIsimQD101hICG9vPbo8P
 xGuM5rqCMc7wxhJE3I+OrwQpVoJEm3yXcb2/hyAV7PZniChILsFvAc0WKA+UyaJ8SdzJ8l6U
 4IScEXY6ySMbE5t7eD3ODRKbYdKbK8gcaVbInlvhNQZDAvQY1bqylCNianPntfeDRmbKBJaq
 Z0JfAqm9NjQxkqhwiAaEXtltKtxuH2qA==
X-Talos-CUID: 9a23:zbeK/GDPMpn8N9H6E3Jj9WEVFdoaTn/Az3uBIlGUBFhxRpTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AIz0Cow99KLQM96mEETRRVGeQf9w4zueyMRETq5x?=
 =?us-ascii?q?YkPi5FSdzJzyGsTviFw=3D=3D?=
Received: from mail-yw1-f197.google.com ([209.85.128.197])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 04 Jul 2023 05:24:22 -0400
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-573a92296c7so49329777b3.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 02:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1688462661; x=1691054661;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F3JSMhxvrHv8Ise1t1pBi33v8ah11OmdcHYzqWclk7c=;
 b=MpXG/s46H7R6C6FmRMp2M+n0cnrYhErenmHgxqbgPqcsHnxjlCwpD/+kcT2KTWePQ0
 4R+bPbCkdplFBIz/Hf/hR99IMYB/1uwrd5WHAEIHJ1kQB2dknffDyljoc/kHy9svAY8H
 MXz8u4phhoG/1Wg/5WjMj/nyhAR4V4+X5ZuCZbMc49P/huxG3cbtTk5UcO15UIIOsv+b
 DQ6gkiQmVkFJ1/ORI8JRzRv5MBTbyPPCq3waZ8xXRu8LwB1FyMeCq3ODoGoPhepYfsNn
 xTXvc+acjJngy666E65LoeIltLfDgGsFg3NOWXSZIYhCxX0rGEBwzp19dcs6zBcvIayH
 G2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688462661; x=1691054661;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F3JSMhxvrHv8Ise1t1pBi33v8ah11OmdcHYzqWclk7c=;
 b=TnH2EZMNnc7R3BSq20jenCP1LW1BjDtdlt7cOYYagrUo0rItGfR7Ztkh4mMyiVFN2O
 2OX6Lg7ge+iWeSOx3xCLWV5ZiPnzgrynryEkpMiizmZxJCl7fpFTpJMlEtNAfconL/XH
 4dCB0sr9sFrNsteC4TG1mtCVKpluTp26EwOKOKH8SVsK9ktFKmwi3tud08vHMOP1qUt3
 T0IAgA9ouqO7yFgEWWTIKYt8UPgvbfFNkTfViVO3AGM/haPsqCD7w2oB5MtbLS/8Nh0F
 WcVlJWy6FOr1PaS+5duCIFvA3PL/WR4MyEEf4XaMtm5mx4tPc1JODjU1stWZkQ2YRLCs
 VspQ==
X-Gm-Message-State: ABy/qLYMWJYVt2cjyWpsGm+J9rdwdklKSm33ZgfzHMIu4XDixU88vAri
 uu7XoJgrPmvrU7yMiKVlaglV98Vl2vqRvQefIfE3nmbkyQYUxl0ZlkM0y8s+T3svcLTImAcnk9d
 u318e3RQOvJGqws61gaoYPelyFySPPA==
X-Received: by 2002:a81:7c8b:0:b0:56d:de2:94d1 with SMTP id
 x133-20020a817c8b000000b0056d0de294d1mr11644768ywc.24.1688462661307; 
 Tue, 04 Jul 2023 02:24:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH23M6Bj7m/LEiaNiFM3dbzmvuc66tjTZCc0tqqLW6SofEc+HIqTL1+zD+5XXrENgOJ2qi8zw==
X-Received: by 2002:a81:7c8b:0:b0:56d:de2:94d1 with SMTP id
 x133-20020a817c8b000000b0056d0de294d1mr11644753ywc.24.1688462661020; 
 Tue, 04 Jul 2023 02:24:21 -0700 (PDT)
Received: from mozz.bu.edu (mozz.bu.edu. [128.197.127.33])
 by smtp.gmail.com with ESMTPSA id
 q130-20020a817588000000b0057725aeb4afsm2949041ywc.84.2023.07.04.02.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 02:24:20 -0700 (PDT)
Date: Tue, 4 Jul 2023 05:24:16 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH] virtio-gpu: fix potential divide-by-zero regression
Message-ID: <20230704092416.c4gt7hyxgwcccjpg@mozz.bu.edu>
References: <20230704091933.2342193-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230704091933.2342193-1-marcandre.lureau@redhat.com>
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=216.71.152.49; envelope-from=alxndr@bu.edu;
 helo=esa2.hc2706-39.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 230704 1119, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Commit 9462ff4695aa0 ("virtio-gpu/win32: allocate shareable 2d
> resources/images") introduces a division, which can lead to crashes when
> "height" is 0.
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1744
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Alexander Bulekov <alxndr@bu.edu>


