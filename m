Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 236757EEB3C
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 03:52:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3oxE-0002d5-V8; Thu, 16 Nov 2023 21:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhouzongmin@kylinos.cn>)
 id 1r3oxD-0002cx-3z
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 21:51:35 -0500
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhouzongmin@kylinos.cn>)
 id 1r3ox7-0002nf-IS
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 21:51:34 -0500
X-UUID: c3657482deb44bf9b7a8f18476b405d4-20231117
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32, REQID:b31d5a39-c5f5-419d-8b11-e30cd25ec5e0, IP:10,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:-5
X-CID-INFO: VERSION:1.1.32, REQID:b31d5a39-c5f5-419d-8b11-e30cd25ec5e0, IP:10,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:5f78ec9, CLOUDID:ff2ba1fc-4a48-46e2-b946-12f04f20af8c,
 B
 ulkID:2311171051224FE9T5VP,BulkQuantity:0,Recheck:0,SF:44|64|66|24|17|19|1
 02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
 L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: c3657482deb44bf9b7a8f18476b405d4-20231117
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
 (envelope-from <zhouzongmin@kylinos.cn>) (Generic MTA)
 with ESMTP id 891262736; Fri, 17 Nov 2023 10:51:20 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
 by mail.kylinos.cn (NSMail) with SMTP id 3149FE0080FF;
 Fri, 17 Nov 2023 10:51:20 +0800 (CST)
X-ns-mid: postfix-6556D528-133057348
Received: from [172.20.12.156] (unknown [172.20.12.156])
 by mail.kylinos.cn (NSMail) with ESMTPA id E4F8AE0080FF;
 Fri, 17 Nov 2023 10:51:18 +0800 (CST)
Message-ID: <6dab8a5d-4982-41b6-92a0-f06c561969c3@kylinos.cn>
Date: Fri, 17 Nov 2023 10:51:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] migration: free 'saddr' since be no longer used
Content-Language: en-US
To: quintela@redhat.com
Cc: peterx@redhat.com, berrange@redhat.com, farosas@suse.de,
 leobras@redhat.com, qemu-devel@nongnu.org
References: <ZVT1c3Ptd_P3Nfb_@x1n>
 <20231116063448.2333616-1-zhouzongmin@kylinos.cn>
 <87il61rdab.fsf@secure.mitica>
From: Zongmin Zhou <zhouzongmin@kylinos.cn>
In-Reply-To: <87il61rdab.fsf@secure.mitica>
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


On 2023/11/16 22:19, Juan Quintela wrote:
> Zongmin Zhou <zhouzongmin@kylinos.cn> wrote:
>> Since socket_parse() will allocate memory for 'saddr',and its value
>> will pass to 'addr' that allocated by migrate_uri_parse(),
>> then 'saddr' will no longer used,need to free.
>> But due to 'saddr->u' is shallow copying the contents of the union,
>> the members of this union containing allocated strings,and will be used after that.
>> So just free 'saddr' itself without doing a deep free on the contents of the SocketAddress.
>>
>> Fixes: 72a8192e225c ("migration: convert migration 'uri' into 'MigrateAddress'")
>> Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
>> ---
>>   migration/migration.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 28a34c9068..9bdbcdaf49 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -493,6 +493,7 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
>>           }
>>           addr->u.socket.type = saddr->type;
>>           addr->u.socket.u = saddr->u;
>> +        g_free(saddr);
>>       } else if (strstart(uri, "file:", NULL)) {
>>           addr->transport = MIGRATION_ADDRESS_TYPE_FILE;
>>           addr->u.file.filename = g_strdup(uri + strlen("file:"));
> Once that we are here, can we move the declaration of saddr to this
> block, so we are sure that we don't use saddr anywhere?
do you mean to do the changes below at this block?
SocketAddress *saddr = socket_parse(uri, errp);
That sounds good and make it clear that 'saddr' is only used on this block.
> As Peter said, putting a comment why we don't use
> qapi_free_SocketAddress() will be a good idea.

I have put some comments on patch v2 to explain

why just free 'saddr' itself without doing a deep free on the contents 
of the SocketAddress .

Maybe need to explicit clarify why g_free is used instead of 
qapi_free_SocketAddress()?


Best regards!

>
> Later, Juan.
>

