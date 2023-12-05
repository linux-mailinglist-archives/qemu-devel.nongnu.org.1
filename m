Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 689C6804EBF
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 10:53:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAS6k-00071R-I2; Tue, 05 Dec 2023 04:52:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hahn@univention.de>)
 id 1rAS6i-00071G-Jf
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 04:52:48 -0500
Received: from mail.univention.de ([82.198.197.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hahn@univention.de>)
 id 1rAS6g-0005Py-Dm
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 04:52:48 -0500
Received: from localhost (localhost [127.0.0.1])
 by lankmoj.knut.univention.de (Postfix) with ESMTP id 895A2102539
 for <qemu-devel@nongnu.org>; Tue,  5 Dec 2023 10:52:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=univention.de;
 s=202111; t=1701769961;
 bh=Hp5H7GdPBhKJ8UdlrCR+0uxBm63pdWItY+Ftff8TlBI=;
 h=Date:To:From:Subject:From;
 b=BfjJEgYfLpXxAfCK/QRi6RKLSBGa7/AxHpRWvJ8EkOUBKjgs7X2rMeLRAp0IYZgLt
 dBShcSy1JbcB3UG8/9NAVZF9YZ3fyF7284K0AvpI5aUtOjdOw4g1DdvNX65n7ynJFl
 H+Dyve87W3A8XidDNprzjy++aar+ksfLzAude7WVJxFFw5wu9kxzQgOahquENgkEWH
 NLA1byXMh2Tc1IL/89/r8kuyzajw2oUg/+Q1o29+1ZDVNi8tG3sGsn0gP8/w/f5Y4T
 ZixBYs5CsWdos7E1XS/QAkXSrCBdyVyN03Mw+PsP/LYmxAo5e5r297+e1NnPXeo9pu
 DUuwnLdmJzzAA==
X-Virus-Scanned: by amavisd-new-2.11.0 (20160426) (Debian) at
 knut.univention.de
Received: from mail.univention.de ([127.0.0.1])
 by localhost (lankmoj.knut.univention.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JeEbntXpbzlp for <qemu-devel@nongnu.org>;
 Tue,  5 Dec 2023 10:52:39 +0100 (CET)
Received: from [172.16.0.193] (opnsense.knut.univention.de [192.168.250.250])
 by lankmoj.knut.univention.de (Postfix) with ESMTPSA id C25A5FEF31
 for <qemu-devel@nongnu.org>; Tue,  5 Dec 2023 10:52:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=univention.de;
 s=202111; t=1701769959;
 bh=Hp5H7GdPBhKJ8UdlrCR+0uxBm63pdWItY+Ftff8TlBI=;
 h=Date:To:From:Subject:From;
 b=Olu19QBpSm4+p3THySNz4ckzrtqeUysAvxtMVaU4FAvA+kSBbqcIjGgtpdhGiyIBS
 9oGI+URz8SFSpTkzbOq1Exxhe9HodrQS5iCP/hCLLFpFjtU71TFtOnk3hlA3b5vTQJ
 AZqKeFLlwzvsmBbhHujSWSj9gsguVBbgoUHFUOgbhNdkkry3qq+B5t0ROcnIyVW1wk
 HqGZ0iogjgFVtpxGrHqX6HRh/sxQ8bkp4rjXWQ21i3e59alW37eAWhUE8FGYVCFCvt
 g86kzk+KqSGluoqK7lQ+22HwC8hjbBYrfH5x5W5UbzynVSWOo7WBgXUjEYjXL4gsGN
 i/Zyp6NKioL5w==
Message-ID: <9447a47d-751c-4913-a60b-8d92f87f2998@univention.de>
Date: Tue, 5 Dec 2023 10:52:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: qemu-devel@nongnu.org
Content-Language: en-US
From: Philipp Hahn <hahn@univention.de>
Subject: "Instant clone" with Qemu?
Autocrypt: addr=hahn@univention.de; keydata=
 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 3toP
Organization: Univention GmbH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=82.198.197.8; envelope-from=hahn@univention.de;
 helo=mail.univention.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello,

by accident I stumbled over "VMware Instant Clone" ¹, which allows 
cloning of running VMs by copy-on-write-sharing the disk images and 
memory content; the network MAC address gets changed (or a different 
bridge is used?).
I wonder if something similar can also be done with Qemu? My current 
solution would be to:
- start and install the VM
- create a live-snapshot into the qcow2 file
- clone the disk image, e.g. put a qcow2 overlay on it per clone
- start and restore the clones from that live-snapshot
- put the clones in individual bridges and let the host do some network 
address translation (NAT) to give each clone a unique external IP address.

Has someone done something similar or is there even a better alternative?

Background: our test suite currently provisions a set of multiple VMs, 
which are dependent on each other. Provisioning them takes sometimes 
many hours. After that the test suite runs inside these VMs and again 
takes many hours.
I'd like to speed that up by parallelizing these tests, e.g.
1. setup the VM environment once
2. clone the VM environments as the resources allow
3. distribute tests over these environments to run in parallel and to 
allow running flaky tests multiple times from a clean clone again

¹<https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-853B1E2B-76CE-4240-A654-3806912820EB.html>
-- 
Philipp Hahn
Open Source Software Engineer

Univention GmbH
Mary-Somerville-Str. 1
28359 Bremen
Germany | Deutschland
Phone: +49 (0)421 22232-0 | E-Mail: info@univention.de

https://www.univention.de | https://www.univention.com

Managing Directors: Peter H. Ganten, Stefan Gohmann
Local court: Amtsgericht Bremen
HRB 20755 | Ust-ID: DE220051310

