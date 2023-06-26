Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7423473ECEE
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 23:32:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDtoA-0004Iw-Fv; Mon, 26 Jun 2023 17:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1qDtnv-0004IZ-Ft; Mon, 26 Jun 2023 17:31:23 -0400
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1qDtns-0006Qg-VU; Mon, 26 Jun 2023 17:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Date:References:
 In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7/wTvMjlR0gYheM4CXQP0Bxtu+4ctcrMyQn+QBXHDEU=; b=VV2oGzJ7fsXPnIljuO60Sv4IJB
 PXWQV9Lz1DLPuHOfBBbxX+aZtVpHJotHO+ao/BFHumiqQDAe8fehYZI5ON20GgAlBw60OIOtRgbKW
 vwE+PUi4J0YO2KisuRWRK17dnPBbsdHxwrZmtC2eEObya7pRUg9o2wsrwZc1NgXFSEp16f5yNK1MM
 sMLMzSHxfv/Upgh7UXdLgsVFx0R1zWtKfurVvKe2pJMjIZYsXLQCrUmdRItFPnDR9yiDvq6pv0i4G
 s0WI2t28CbcyTLmswBwv322Qyw/RCTh07VNI8JDzI+6U3D0ui3/Gf53AGE8E31YgEreik4vLApnP2
 a+6i58iw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1qDtnr-004Cb5-3x; Mon, 26 Jun 2023 23:31:19 +0200
Received: from gate.service.igalia.com ([192.168.21.52])
 by mail.igalia.com with esmtp (Exim)
 id 1qDtnp-00DPvy-0H; Mon, 26 Jun 2023 23:31:18 +0200
Received: from berto by gate.service.igalia.com with local (Exim 4.94.2)
 (envelope-from <berto@igalia.com>)
 id 1qDtno-009vNG-Dn; Mon, 26 Jun 2023 21:31:16 +0000
From: Alberto Garcia <berto@igalia.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH 4/5] test-throttle: test read only and write only
In-Reply-To: <20230625085631.372238-5-pizhenwei@bytedance.com>
References: <20230625085631.372238-1-pizhenwei@bytedance.com>
 <20230625085631.372238-5-pizhenwei@bytedance.com>
Date: Mon, 26 Jun 2023 21:31:16 +0000
Message-ID: <w51pm5h52sb.fsf@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=213.97.179.56; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
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

On Sun 25 Jun 2023 04:56:30 PM +08, zhenwei pi wrote:
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

