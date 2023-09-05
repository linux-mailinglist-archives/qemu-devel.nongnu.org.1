Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D427923C5
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 17:06:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdXcg-0005wj-LF; Tue, 05 Sep 2023 11:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sylv@sylv.io>) id 1qdXce-0005wX-Ay
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:05:44 -0400
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <sylv@sylv.io>) id 1qdXcb-0007gQ-Lc
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:05:44 -0400
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Rg82S4PhDz9sqj;
 Tue,  5 Sep 2023 17:05:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
 t=1693926336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YlBCCz0zPoCGXu2vuJhM3+iDuUcAs5XoG4ghB/B72K8=;
 b=ds2Z1z0CMTRym+Go6g0HVriwMzsH0PTP5Px9nWCXwsrQ2tBgxvNGYCSbvBUyWDW7ulOw4n
 eXetK2w1hRq+EAmTytpbnxfeP8NtLwZtVeLDomAjsaJ69mXk0poICNZoI1i/Roon3wJZim
 YFscvlfoZBN8ZJ0zakd+fSBQej/KyVNlfujUj1rg90giKoZ8xl7RPyF27b+DTJtypRO6ij
 M2NTopx+BTrYF8xnCDr937Po4wwO+BAGEVERSvcKLO8pSp2F8xGRKfPOOxasdFGvmMohgd
 68Xx5qwcpOkNzDK9iFIanzCXS/PGhQdpoLqEfYi1G63RvlnxIGPRhV2DVPrnSg==
Message-ID: <66949448-1577-444a-b6d2-d907f9870765@sylv.io>
Date: Tue, 5 Sep 2023 17:05:33 +0200
MIME-Version: 1.0
Content-Language: en-US, de-DE
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, ani@anisinha.ca,
 Patrick Rudolph <patrick.rudolph@9elements.com>
From: Marcello Sylverster Bauer <sylv@sylv.io>
Subject: PCI Hotplug ACPI device names only 3 characters long
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4Rg82S4PhDz9sqj
Received-SPF: pass client-ip=80.241.56.152; envelope-from=sylv@sylv.io;
 helo=mout-p-102.mailbox.org
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Greetings,

I'm currently working on a project to support Intel IPU6 in QEMU via 
VFIO so that the guest system can access the camera. This requires 
extending the ACPI device definition so that the guest knows how to 
access the camera.

However, I cannot extend the PCI devices because their names are not 4 
characters long and therefore do not follow the ACPI specification.

When I use '-acpitable' to include my own SSDT for the IPU6 PCI device, 
it does not allow me to declare the device as an External Object because 
it automatically adds padding underscores.

e.g.
Before:
```
External(_SB.PCI0.S18.SA0, DeviceObj)
```
After:
```
External(_SB.PCI0.S18_.SA0_, DeviceObj)
```

Adding the underscore padding is hard coded in iASL and also in QEMU 
when parsing an ASL file. (see: build_append_nameseg())

So here are my questions:
1. Is there a solution to extend the ACPI PCI device using '-acpitable' 
without having to patch iASL or QEMU?
2. Are there any plans to change the names to comply with the ACPI spec? 
(e.g. use "S%.03X" format string instead)

Thanks
Marcello

