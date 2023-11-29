Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A037FCC94
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 03:11:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8A1Q-00077A-SR; Tue, 28 Nov 2023 21:09:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhouzongmin@kylinos.cn>)
 id 1r8A1M-00076e-Ub
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 21:09:48 -0500
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhouzongmin@kylinos.cn>)
 id 1r8A1F-0006Q7-82
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 21:09:48 -0500
X-UUID: 9a885ef456bc48f48bbbe9be2d58631f-20231129
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33, REQID:f0dce4fe-4928-4a72-84cd-996dd2ba8007, IP:20,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:5
X-CID-INFO: VERSION:1.1.33, REQID:f0dce4fe-4928-4a72-84cd-996dd2ba8007, IP:20,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:5
X-CID-META: VersionHash:364b77b, CLOUDID:3c68ed95-10ce-4e4b-85c2-c9b5229ff92b,
 B
 ulkID:23112910091579UA9F0P,BulkQuantity:0,Recheck:0,SF:24|17|19|44|64|66|1
 02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
 L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 9a885ef456bc48f48bbbe9be2d58631f-20231129
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
 (envelope-from <zhouzongmin@kylinos.cn>) (Generic MTA)
 with ESMTP id 985164105; Wed, 29 Nov 2023 10:09:14 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
 by mail.kylinos.cn (NSMail) with SMTP id 04FE2E0080FF;
 Wed, 29 Nov 2023 10:09:14 +0800 (CST)
X-ns-mid: postfix-65669D49-937395453
Received: from [172.20.12.156] (unknown [172.20.12.156])
 by mail.kylinos.cn (NSMail) with ESMTPA id 0945CE0080FF;
 Wed, 29 Nov 2023 10:09:12 +0800 (CST)
Message-ID: <7b1c8be9-788a-4cf1-aa6a-ad8f718d7118@kylinos.cn>
Date: Wed, 29 Nov 2023 10:09:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] migration: free 'saddr' since be no longer used
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: berrange@redhat.com, farosas@suse.de, leobras@redhat.com,
 qemu-devel@nongnu.org, quintela@redhat.com
References: <ZVdw_XMJ4mKMFejd@x1n>
 <20231120031428.908295-1-zhouzongmin@kylinos.cn> <ZVtmn0WXTKPxCbKU@x1n>
From: Zongmin Zhou <zhouzongmin@kylinos.cn>
In-Reply-To: <ZVtmn0WXTKPxCbKU@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=zhouzongmin@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Ping? Has this been forgotten?

Best regards!

On 2023/11/20 22:01, Peter Xu wrote:
> On Mon, Nov 20, 2023 at 11:14:28AM +0800, Zongmin Zhou wrote:
>> Since socket_parse() will allocate memory for 'saddr',and its value
>> will pass to 'addr' that allocated by migrate_uri_parse(),
>> then 'saddr' will no longer used,need to free.
>> But due to 'saddr->u' is shallow copying the contents of the union,
>> the members of this union containing allocated strings,and will be used after that.
>> So just free 'saddr' itself without doing a deep free on the contents of the SocketAddress.
>>
>> Fixes: 72a8192e225c ("migration: convert migration 'uri' into 'MigrateAddress'")
>> Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>

