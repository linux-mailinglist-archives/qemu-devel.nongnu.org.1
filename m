Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 918A37C9FB4
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 08:37:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsHDy-0006MQ-6I; Mon, 16 Oct 2023 02:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsHDs-0006M5-73
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:37:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsHDq-0006T9-JA
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697438221;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=bEXPhc9ZDGUoVdKZyWDdxTHbaIBntheR/sWDQJtzRSo=;
 b=g6oJgsF5SJ1XFpAP1cdtHjo7xUhkJtJDJG17vSk2oSOiLFf+IGLdmHyVljKOnbZOC8WTp/
 RGbPyv086SiyppjFdQEpkwxc+WbTXKW2niPfpfExDrY0cWtS+wWq37YHUxSCQBn7qSZuI1
 QMOPttT0i0iPJoVyx1mPpqaHRM1/4Lo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-VJX3B9iXNsKatIj3LffsDQ-1; Mon, 16 Oct 2023 02:37:00 -0400
X-MC-Unique: VJX3B9iXNsKatIj3LffsDQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4077ea9eea9so9416355e9.3
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 23:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697438219; x=1698043019;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bEXPhc9ZDGUoVdKZyWDdxTHbaIBntheR/sWDQJtzRSo=;
 b=hTw8ypG7QRa9gm9A62NoWtzQmT55JYw1iOXVBJlKfjwl3VTjC4W6GJoKn3NTWInVxI
 F+fpSaDfh6ltc96al+I8bg7sLjaEI4WasxC6RL2E+xJOB3RS1CGDRzutHX0Ie98EiXER
 eNXO2vj4Zx1eeoVBFnIBYy+GMhO5DwQcpu5icwDdJ4HZenAPeGNf6Mg7pcpYIdMG7XLN
 aj8EVQNhyaN8NqGytrEEAOWi2kAEkSwH3IiDNHDXugV4PbUJFubRK2Ojwlx8tEGuCaZ0
 KoKEJ8sr8k33uYoPat4Aa7TEyUWPvrhIRliW84KCqCyCQFQ5ITsE3za5N/Go8yoQu28t
 epnA==
X-Gm-Message-State: AOJu0Yz0Vwhdu5jQfTVdKTfA0371NfQIGcF70Rio9cD/FW16tdH4mUXe
 R16VsVUZ5LV+wDaeJvx4moOSiGUd4xxlH+js1uFPqneRusacTDzZQUA1sCJmlC9x5hcg25HoNGX
 tssqWG2cUj8mtysQ=
X-Received: by 2002:a05:600c:b59:b0:401:b1c6:97dc with SMTP id
 k25-20020a05600c0b5900b00401b1c697dcmr28743297wmr.23.1697438219047; 
 Sun, 15 Oct 2023 23:36:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9GsUuI8MgeaTsOj6csfiIxBBoHMdThyXXgyc880KtKnGormIJM4xqofSRm1KNdxxKV3Y+cQ==
X-Received: by 2002:a05:600c:b59:b0:401:b1c6:97dc with SMTP id
 k25-20020a05600c0b5900b00401b1c697dcmr28743280wmr.23.1697438218611; 
 Sun, 15 Oct 2023 23:36:58 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 n9-20020a05600c500900b00401b242e2e6sm6314118wmr.47.2023.10.15.23.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 23:36:57 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH v3 13/13] migration/rdma: Remove all "ret" variables
 that are used only once
In-Reply-To: <87wmvrzyri.fsf@suse.de> (Fabiano Rosas's message of "Thu, 12 Oct
 2023 11:44:17 -0300")
References: <20231011203527.9061-1-quintela@redhat.com>
 <20231011203527.9061-14-quintela@redhat.com> <87wmvrzyri.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 16 Oct 2023 08:36:56 +0200
Message-ID: <87edhv5b07.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> Juan Quintela <quintela@redhat.com> writes:
>
>> Change code that is:
>>
>> int ret;
>> ...
>>
>> ret = foo();
>> if (ret[ < 0]?) {
>>
>> to:
>>
>> if (foo()[ < 0]) {
>>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/rdma.c | 29 ++++++++---------------------
>>  1 file changed, 8 insertions(+), 21 deletions(-)
>>
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index a43527a83c..c382588b26 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -1107,7 +1107,6 @@ err_alloc_pd_cq:
>>  static int qemu_rdma_alloc_qp(RDMAContext *rdma)
>>  {
>>      struct ibv_qp_init_attr attr = { 0 };
>> -    int ret;
>>  
>>      attr.cap.max_send_wr = RDMA_SIGNALED_SEND_MAX;
>>      attr.cap.max_recv_wr = 3;
>> @@ -1117,8 +1116,7 @@ static int qemu_rdma_alloc_qp(RDMAContext *rdma)
>>      attr.recv_cq = rdma->recv_cq;
>>      attr.qp_type = IBV_QPT_RC;
>>  
>> -    ret = rdma_create_qp(rdma->cm_id, rdma->pd, &attr);
>> -    if (ret < 0) {
>> +    if (rdma_create_qp(rdma->cm_id, rdma->pd, &attr) < 0) {
>
> This particular pattern hurts readability IMO. See how the < 0 got
> pushed all the way to the end of the line. The longer the list of
> arguments, the larger the chance of missing the < 0 when glancing over
> the code.

You can't have both:

* No "ret" variable that is used only once.
* make the condition line small

I choosed the 1st one.  For "ret" I always asume that you set it in one
place and you use it in multiple places.  Otherwise you don't need it.

But I can understand the other point of view.

There is a reason that this patch was last O:-)

> Anyway:
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Thanks.


