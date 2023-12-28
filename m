Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D436E81FB86
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 23:21:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIyk0-00010J-Fk; Thu, 28 Dec 2023 17:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xtec@trimaso.com.mx>)
 id 1rIuST-0008Q0-17
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 12:46:13 -0500
Received: from butterfly.birch.relay.mailchannels.net ([23.83.209.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xtec@trimaso.com.mx>)
 id 1rIuSQ-0005sp-UR
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 12:46:12 -0500
X-Sender-Id: spamcontrol26|x-authuser|xtec@trimaso.com.mx
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id B97207A393E
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 17:45:27 +0000 (UTC)
Received: from single-9040.banahosting.com (unknown [127.0.0.6])
 (Authenticated sender: spamcontrol26)
 by relay.mailchannels.net (Postfix) with ESMTPA id 29BAA7A396A
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 17:45:27 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1703785527; a=rsa-sha256;
 cv=none;
 b=nat74Xs6t6t4MUikeE5q35R0UIkId4Mw2/NIEA3wvhIjuYJ7rjgvvusJkCpCNv81D/fjFs
 QW/UH6YPli2PJcus7Xj9d9xj7Lnhf7Dczt8V4qK7t9vWZkrOS7BScNhNtMDH2w6BVFeaZ7
 r5lg19djrV/zWtbAq6o69WvxactoNiPKvHUSZ8EjWa6hoqALjwtU7lact7hOp4HazX1TwZ
 hrsRGWbFwY+0SZjHO3HEL0AAY1XFKLob6fjlEEx/GCukj9DgAWIJlsPYIVXj9FI5M0I/n1
 +5vl9L62sJu6aA6lKXGrN8UB4IEKHbr5p75pCKznMFvfCcbCBi6hG0jYKPmZjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1703785527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=NjeiiWhNjpK5R+HusWUSy8cqG5KyARb7Xz2Xkf7uqyk=;
 b=UPVej87elKKxG2SA4b5w6gd/x/p5oOxMwFQTXvsqF6WOMTcfq+VS85iHgJGP17JtRNGqDB
 RMBi6mss+jxXc6NAJhdeLqG8RDMgATRXYWw452UqUtGl9sM0JQV333tM6KN3zUDIFuroFh
 B1zioVfywfltnJuPt4j9TE0sEK4hQaGod/ygDAgXkFzJLSNBC5J48g1ttV7YzZvRuHinav
 zd04d2F55kqN/RFpnYOFj9ryVxkh42smeYC53MhPUF0d49bZbt/3M8Ageh2HeibtpF73Gp
 P8SZohnhiAjYE86VLpuumFtca+H3+m6vI3dHFaKoRnilLYcP7H4CEjzt8S2ipg==
ARC-Authentication-Results: i=1; rspamd-856c7f878f-jfbj2;
 auth=pass smtp.auth=spamcontrol26 smtp.mailfrom=xtec@trimaso.com.mx
X-Sender-Id: spamcontrol26|x-authuser|xtec@trimaso.com.mx
X-MC-Relay: Neutral
X-MailChannels-SenderId: spamcontrol26|x-authuser|xtec@trimaso.com.mx
X-MailChannels-Auth-Id: spamcontrol26
X-Stupid-Lonely: 6cc53e757023daa9_1703785527502_1250413169
X-MC-Loop-Signature: 1703785527502:959421692
X-MC-Ingress-Time: 1703785527502
Received: from single-9040.banahosting.com (single-9040.banahosting.com
 [66.225.201.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
 by 100.97.59.136 (trex/6.9.2); Thu, 28 Dec 2023 17:45:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=trimaso.com.mx; s=default; h=Content-Transfer-Encoding:Content-Type:
 Message-ID:Subject:To:From:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NjeiiWhNjpK5R+HusWUSy8cqG5KyARb7Xz2Xkf7uqyk=; b=R8N3M603rzeAbnkwYz5BBELyPV
 UIQzUTeTv41MpYvA8LK1QesQA5oIi4uSLn1L7xIWV3Ld7TBo/+kh9AyQRorHnpC394S9A1ilOLDgx
 L5ghHAyGFNc2KN5syiYhMkJ+Shz/3q7pyB9T2ghNw1n7y1m9WtyW+w38ndhyzR4bmXeejx59EtXi5
 LW9nA4vojqQOZ8cPnnAIix2G2S6niNS+gw6Swuc0YgohgV/lBdhyc6ga175b3J1Bi7+h/oJztuFPk
 YO9ExWioQhziAGPQ+jdji+B84CzNZ7QWUay4o4E2P21ZWP9ooNEQo/6pmvKdsd3CI5KdR7CTGCOTY
 K8MrmB7g==;
Received: from [::1] (port=42860 helo=single-9040.banahosting.com)
 by single-9040.banahosting.com with esmtpa (Exim 4.96.2)
 (envelope-from <xtec@trimaso.com.mx>) id 1rIuRZ-00053V-13
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 12:45:22 -0500
MIME-Version: 1.0
Date: Thu, 28 Dec 2023 11:45:18 -0600
From: xtec@trimaso.com.mx
To: qemu-devel@nongnu.org
Subject: Qemu setting "-cpu host" seems broken with Windows vms
User-Agent: Roundcube Webmail/1.6.0
Message-ID: <8cceee40e32dab3e1913e50c221475ea@trimaso.com.mx>
X-Sender: xtec@trimaso.com.mx
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-cPanel-MailScanner-Information: Please contact the ISP for more information
X-cPanel-MailScanner-ID: 1rIuRZ-00053V-13
X-cPanel-MailScanner: Found to be clean
X-cPanel-MailScanner-SpamCheck: 
X-cPanel-MailScanner-From: xtec@trimaso.com.mx
X-AuthUser: xtec@trimaso.com.mx
Received-SPF: softfail client-ip=23.83.209.27;
 envelope-from=xtec@trimaso.com.mx; helo=butterfly.birch.relay.mailchannels.net
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 28 Dec 2023 17:20:32 -0500
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

I noticed something weird when using "-cpu host" with Windows vms.
First, I always use it along with ",hv_passthrough" as well.

First, performance: since some years ago, since prior to qemu 6.2 until 
latest 8.2, win10 and win11 vms always worked slower than expected. This 
could be noticed by comparing booting/starting times between vm and a 
bare metal installation, but I particularly measured it when installing 
windows cumulative updates through windows update. On vm, from 
downloading to finishing rebooting it always took 1.5 circa 1.5 hours, 
while just 40 minutes on bare metal.

Second, and more recently, newer windows 11 23h2 seems to have big 
problem with "-cpu host".
When trying to update from 22h2 to 23h2 I got either black screen or 
bsod after trying to reboot.
Also, same result when trying to install 23h2 from scratch.
This on qemu 7.1 and 8.2.
Did a long search, and finally found the cause which also solved the 
problem for me:
https://forum.proxmox.com/threads/new-windows-11-vm-fails-boot-after-update.137543/
I found similar problems and similar solution in other forums as well.

So in my case, physical host cpu is intel core 11th gen; tried using 
libvirt's "virsh capabilities" to see which qemu cpu model better 
matched, and for some reason it gave Broadwell instead of newer 
Skylake...
Anyway, tried with "-cpu <Broadwell_model>,hv_passthrough", and this 
solved *both* problems: performance finally matched bare metal in all 
aspects, and the windows 23h2 problem was finally gone.

On IRC, it was suggested to try "-cpu host" and "disabling CPU bits" one 
by one until finding the culprit. But I don't know how to do this...

Could someone look into this?
Thanks.

