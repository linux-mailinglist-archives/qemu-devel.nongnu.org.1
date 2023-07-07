Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C21274A862
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 03:17:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHa3r-000709-Tb; Thu, 06 Jul 2023 21:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangjianguo18@huawei.com>)
 id 1qHa3o-0006zT-QV
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 21:15:00 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangjianguo18@huawei.com>)
 id 1qHa3m-0001yV-7V
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 21:15:00 -0400
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QxwNz5X65zPk0H;
 Fri,  7 Jul 2023 09:12:35 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 09:14:49 +0800
Received: from dggpemm500018.china.huawei.com ([7.185.36.111]) by
 dggpemm500018.china.huawei.com ([7.185.36.111]) with mapi id 15.01.2507.027;
 Fri, 7 Jul 2023 09:14:49 +0800
To: Fabiano Rosas <farosas@suse.de>, "peterx@redhat.com" <peterx@redhat.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Liheng <liheng.liheng@huawei.com>, Renxuming <renxuming@huawei.com>,
 "Pengyi (pengyi)" <pengyi.pengyi@huawei.com>, "huhao (N)"
 <huhao33@huawei.com>, "zhangjianguo (A)" <zhangjianguo18@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>
Subject: =?gb2312?B?s7e72DogUWVtdSBhc2FuIHRlc3QgcmVwb3J0ZWQgaGVhcC11c2UtYWZ0ZXIt?=
 =?gb2312?Q?free_error_when_using_qxl_and_spice?=
Thread-Topic: Qemu asan test reported heap-use-after-free error when using qxl
 and spice
Thread-Index: AQHZsHBtjfDNrQouRe6mKaJ5sz+Xlw==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 17
X-FaxNumberOfPages: 0
Date: Fri, 7 Jul 2023 01:14:49 +0000
Message-ID: <2d44a020525f403cbec2a34d5b031192@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.184.217]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.189;
 envelope-from=zhangjianguo18@huawei.com; helo=szxga03-in.huawei.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 MIME_CHARSET_FARAWAY=2.45, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Reply-to:  "zhangjianguo (A)" <zhangjianguo18@huawei.com>
From:  "zhangjianguo (A)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

emhhbmdqaWFuZ3VvIChBKSC9q7O3u9jTyrz+obBRZW11IGFzYW4gdGVzdCByZXBvcnRlZCBoZWFw
LXVzZS1hZnRlci1mcmVlIGVycm9yIHdoZW4gdXNpbmcgcXhsIGFuZCBzcGljZaGxoaM=

