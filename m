Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B70E47DEA69
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:50:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMpY-0004yB-EW; Wed, 01 Nov 2023 21:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leohou163@163.com>) id 1qyMpU-0004tN-0m
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:49:04 -0400
Received: from m15.mail.163.com ([45.254.50.220])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <leohou163@163.com>) id 1qyMpQ-0000Il-T8
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Mime-Version:Message-ID:
 Content-Type; bh=PGrcUpXrEmUS79ddlAfOLzSGmJja1eI1z8Xnqhj/kpY=;
 b=mDSTm6ftATbVPsnHAFuYKXBRnlgNMC/scZdxRoPyTMgA/xBYxtH0ciwDZUimOf
 o1DUVmkI+fkyURBjZ3gXOl2Il49vFrkmvyeQIvRlxWCeopDWc5VQpo45TEnSQ7p2
 Dm2w0TRcmN3gSINEsBTSZSJJOmq3/+HAQHSrsiTL6nwX8=
Received: from DESKTOP-2O3KOGU (unknown [114.255.110.130])
 by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wCnj5X9_0JlAUghBg--.3364S2; 
 Thu, 02 Nov 2023 09:48:47 +0800 (CST)
Date: Thu, 2 Nov 2023 09:48:46 +0800
From: "leohou163@163.com" <leohou163@163.com>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: =?utf-8?B?5Zue5aSNOiDmnaXoh6pMZW8gSG9155qE6YKu5Lu2?=
References: <c295140.2281.18b83b65ec4.Coremail.leohou163@163.com>
X-Priority: 3
X-GUID: 0AE0047B-253A-4743-888C-17ADCDB509B2
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.228[cn]
Mime-Version: 1.0
Message-ID: <202311020948453815861@163.com>
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-CM-TRANSID: _____wCnj5X9_0JlAUghBg--.3364S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RXucEUUUUU
X-Originating-IP: [114.255.110.130]
X-CM-SenderInfo: xohrx0jxrwjqqrwthudrp/
Received-SPF: pass client-ip=45.254.50.220; envelope-from=leohou163@163.com;
 helo=m15.mail.163.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

aGkgLCBhbGwKCgrCoMKgwqDCoMKgIERvZXMgcWVtdSBwbGFuIHRvIHN1cHBvcnQgQ1BVIGhldGVy
b2dlbmVpdHk/CgoKCgoKwqDCoMKgwqAKCgo=


