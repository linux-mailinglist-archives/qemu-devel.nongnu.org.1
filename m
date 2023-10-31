Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D72B47DC4DC
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 04:27:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxfOY-00046w-2a; Mon, 30 Oct 2023 23:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leohou163@163.com>) id 1qxfOV-00046o-Vq
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 23:26:20 -0400
Received: from m13108.mail.163.com ([220.181.13.108])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <leohou163@163.com>) id 1qxfOS-0006nu-V7
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 23:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=bJuZEbcmZ4YQHt+5zobpHkEIRFK4sGdvf5j1k3GoXfE=; b=U
 trt+EnOGeSaZ+BZiEthZHGW++DcgLKfYsv1UIPr6M2xGY9nTq3HcEMVXo5Cdp7uF
 +l0NsVBFCTPrl5PAczI1V9ZK2J0c7kHQriw8I55TBx5Ek3wU9YbDCbYE7I+Bz2ZV
 hBZY/PcAehdBl7hVDlGEEGwPEevuZZLSt9HC59Q4ug=
Received: from leohou163$163.com ( [114.255.110.130] ) by
 ajax-webmail-wmsvr108 (Coremail) ; Tue, 31 Oct 2023 11:10:49 +0800 (CST)
X-Originating-IP: [114.255.110.130]
Date: Tue, 31 Oct 2023 11:10:49 +0800 (CST)
From: "Leo Hou" <leohou163@163.com>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: =?GBK?Q?=C0=B4=D7=D4Leo_Hou=B5=C4=D3=CA=BC=FE?=
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
X-NTES-SC: AL_QuySCvuZvkAv7yCaY+kfm0wVhew9X8axs/wk1YZeOJh6jDrmxgISQmFkN2bK2sisBx2dmz+wbwZt1+9fcbtzcKEwn/TimMMI8tomvsztHGrabw==
Content-Type: multipart/alternative; 
 boundary="----=_Part_32814_1476562639.1698721849028"
MIME-Version: 1.0
Message-ID: <c295140.2281.18b83b65ec4.Coremail.leohou163@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: bMGowAD3P1k5cEBlnz8AAA--.267W
X-CM-SenderInfo: xohrx0jxrwjqqrwthudrp/1tbiMh8NPlWB6EZU3QADsu
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.181.13.108; envelope-from=leohou163@163.com;
 helo=m13108.mail.163.com
X-Spam_score_int: 38
X-Spam_score: 3.8
X-Spam_bar: +++
X-Spam_report: (3.8 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 MIME_CHARSET_FARAWAY=2.45, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

------=_Part_32814_1476562639.1698721849028
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

aGkgLCBhbGwKICAgICAgRG9lcyBxZW11IHBsYW4gdG8gc3VwcG9ydCBDUFUgaGV0ZXJvZ2VuZWl0
eT8KCiAgICAK
------=_Part_32814_1476562639.1698721849028
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+aGkgLCBhbGw8L2Rpdj48
ZGl2IHN0eWxlPSJtYXJnaW46MDsiPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBEb2Vz
IHFlbXUgcGxhbiB0byBzdXBwb3J0IENQVSBoZXRlcm9nZW5laXR5Pzxicj48L2Rpdj48ZGl2IHN0
eWxlPSJtYXJnaW46MDsiPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyA8YnI+PC9kaXY+PC9kaXY+

------=_Part_32814_1476562639.1698721849028--


