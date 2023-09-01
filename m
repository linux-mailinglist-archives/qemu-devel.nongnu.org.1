Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D4678FC41
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 13:28:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc2IZ-0008Kf-5W; Fri, 01 Sep 2023 07:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>)
 id 1qc2IV-0008Ec-58; Fri, 01 Sep 2023 07:26:43 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>)
 id 1qc2IR-0002wa-UG; Fri, 01 Sep 2023 07:26:42 -0400
Message-ID: <483510b6-dc31-c53c-b114-03aa249c3478@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1693567595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gJaPn2xjGt733Dt5Xr2riqt4MDs+Omivqy5q+Lg9scY=;
 b=nGL15YDuYDw+2DjewGcf+rV1zxo0k2E24Kn3yuPj0RTixJs+jcjLiQcsAEW9VCYCF5ATcm
 zLTULEvsKZBmJebX/u06AZhEIcFkMYYRliPaBEpmM5ry2C2J07iRH2iz6EyJp36lFWRSBm
 hfgic5RAxNwt4g9w470twi4j6MjVVks=
Date: Fri, 1 Sep 2023 14:26:34 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] fix bdrv_open_child return value check
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, fam@euphon.net,
 hreitz@redhat.com, sdl.qemu@linuxtesting.org
References: <20230831125926.796205-1-frolov@swemel.ru>
 <ZPHH3N8RiMxNa13F@redhat.com>
From: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>
In-Reply-To: <ZPHH3N8RiMxNa13F@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hello, Kevin.

This was just cleanup, based on the inspection.

Dmitry.

01.09.2023 14:15, Kevin Wolf пишет:
> Am 31.08.2023 um 14:59 hat Dmitry Frolov geschrieben:
>> bdrv_open_child() may return NULL.
>> Usually return value is checked for this function.
>> Check for return value is more reliable.
>>
>> Fixes: 24bc15d1f6 ("vmdk: Use BdrvChild instead of BDS for references to extents")
>>
>> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> Did you actually see some failure because of this? If so, what is the
> specific case that failed?
>
> Or is this just cleanup based on code inspection?
>
> Kevin
>


