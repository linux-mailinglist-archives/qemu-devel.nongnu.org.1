Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF65B1935B
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Aug 2025 11:51:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiVMX-0004bt-H5; Sun, 03 Aug 2025 05:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uiVMH-0004Ra-D3
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 05:50:26 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uiVME-0003sn-9r
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 05:50:24 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5739oBrH015056
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 3 Aug 2025 18:50:11 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=lmJYQTvjFhc2YN6bWJoFpcmGKTs1EVYe8WHABMCHLKc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1754214611; v=1;
 b=eLwFI2b3pG8xMrUX6MJb0T+9Ofmwfs/UYad9dN/Jqjl0fj2yx63Obg/DghPiYHb2
 QwT0Cz6x9coiyjql/FRhcgXXIlepbrf1sKyXrmf6XD2frqCmLTK0NdNdAQ450QsD
 kM+qOqB0P7yuVeZjccZBtyqcW92kltik/tmdNyR/PQL6WwZy+ey/XU6E3JLeQOZF
 xiNIvhARj0byHDBBeOAWDQ9p1tOABxcrIg6KyBmwKbDCQ8wsO9oTWLEPMS1cres+
 jD/AeSylqPYSgx4GACY2gZIEd5ivU7BqJRi8sXXEKMBbi+AWxlOfsHda0/akNXTO
 /L6pHylPaOtYFvYWyA8XRQ==
Message-ID: <7c282155-340e-44a6-9790-0a37f330eb30@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 3 Aug 2025 18:50:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] virtio-net: make VirtIONet.vlans an array instead
 of a pointer
To: Michael Tokarev <mjt@tls.msk.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <20250802142115.41638-1-mjt@tls.msk.ru>
 <20250803085443.318611-1-mjt@tls.msk.ru>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250803085443.318611-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/08/03 17:54, Michael Tokarev wrote:
> This field is a fixed-size buffer (number of elements is MAX_VLAN,
> known at build time).  There's no need to allocate it dynamically,
> it can be made an integral part of VirtIONet structure.
> 
> This field is the only user of VMSTATE_BUFFER_POINTER_UNSAFE() macro.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

