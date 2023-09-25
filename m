Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 039327AD71B
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 13:41:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkjxG-0004EZ-Nz; Mon, 25 Sep 2023 07:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1qkjxE-0004EO-9V
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 07:40:44 -0400
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1qkjxB-0004Nv-6R
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 07:40:44 -0400
Received: from [IPV6:2a02:a03f:eaf7:ff01:ecd9:958e:7098:f62b] (unknown
 [IPv6:2a02:a03f:eaf7:ff01:ecd9:958e:7098:f62b])
 by apollo.dupie.be (Postfix) with ESMTPSA id 786831520C25;
 Mon, 25 Sep 2023 13:40:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1695642035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xdzMrzAIJUNsoaGtXNO3OJXF0kbqdihYOb3ENZ+i/CA=;
 b=TnzskA1MSm/U+c3oGQD5xLi5JVJDSAq+E2MbMT70LY6stDtXFq7mrsbtoT04UOV1IZFJDL
 Mov1+YAdu4rZiOhEah0YKIWrOdLiIdbOpnmRqbnK/V0AyQca5r5DVh/1qNZ0HA25Uz83Iw
 abVjtpWzw/efLKj+Ov3QxZLgDpx3FJGk+abz/+kZPDWqPCZGQ5XxP4Bt7ZxQCA8vPw4CeT
 vdBaFmQoas2hGwu4FJwFyTXZpPFzdO5WjpKbh/+5zQWXSZff110i7XMSXoDYo5hDE77uu7
 PLKVsdKeDFAt0f4OPBxg0W2qbau4hovxB8BB8hPTlYrj8av5mnuV9e/xzVgDSA==
Message-ID: <0208337f-92ac-4019-909b-2c3d333c46de@dupond.be>
Date: Mon, 25 Sep 2023 13:40:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] qcow2: keep reference on zeroize with discard-no-unref
 enabled
To: Hanna Czenczek <hreitz@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com
References: <20230905130839.923041-2-jean-louis@dupond.be>
 <1088caf4-3f59-84be-25d4-f2574674cb2a@redhat.com>
Content-Language: en-US
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <1088caf4-3f59-84be-25d4-f2574674cb2a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=51.159.20.238; envelope-from=jean-louis@dupond.be;
 helo=apollo.dupie.be
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

On 15/09/2023 13:21, Hanna Czenczek wrote:
> On 05.09.23 15:08, Jean-Louis Dupond wrote:
>> When the discard-no-unref flag is enabled, we keep the reference for
>> normal discard requests.
>> But when a discard is executed on a snapshot/qcow2 image with backing,
>> the discards are saved as zero clusters in the snapshot image.
>>
>> When committing the snapshot to the backing file, not
>> discard_in_l2_slice is called but zero_in_l2_slice. Which did not had
>> any logic to keep the reference when discard-no-unref is enabled.
>>
>> Therefor we add logic in the zero_in_l2_slice call to keep the reference
>> on commit.
>>
>> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1621
>> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
>> ---
>>   block/qcow2-cluster.c | 22 ++++++++++++++++++----
>>   1 file changed, 18 insertions(+), 4 deletions(-)
>
> The code looks OK, but the obvious problem I find is that this is not 
> what the discard-no-unref option describes.  It talks about discards, 
> but this now changes the zero-write path.
But it's still touching the discard code in the zeroize code path.
Cause we modify the way zeroize does its discard (when BDRV_REQ_MAY_UNMAP)
>
> I’m fairly certain that you are the only one using this option for 
> now, so we might as well change its definition to include zero writes 
> for 8.2, but we should do that.
I agree. How would you name the option then? Cause it still involves 
discard-only code.
Next to that, the option was already added to libvirt also (so this 
needs to be fixed afterwards also).
>
> Hanna
>


