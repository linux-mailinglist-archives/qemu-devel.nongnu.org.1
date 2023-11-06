Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C71757E27AB
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:51:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00wv-0004ZM-9D; Mon, 06 Nov 2023 09:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1r00wq-0004Xk-EB
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:51:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1r00wn-0004DF-L8
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699282284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aIC4mcDXv3rGwgW0S+PoTw8JNZ/T7SpLeXnezQeuu5o=;
 b=auQShLgkLE64IQ/SHahT3NawmQP/swndEIVe6OTNECHxqYM9ZPzXBQ45NfOhxUaWE4cGOF
 MqNoowEjWq7zWoIMMc/0yiByet4Um75tDSjNxyNxlp4uHUw2/GmDPh+NiQs+0oFqbClaWx
 eWRdN06IWEuk2Tirdq8rAXH1MdZbtj8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-hG9_DdS-MHOBBbTz42UahQ-1; Mon, 06 Nov 2023 09:51:23 -0500
X-MC-Unique: hG9_DdS-MHOBBbTz42UahQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32f7cfab43eso2142392f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 06:51:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699282282; x=1699887082;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aIC4mcDXv3rGwgW0S+PoTw8JNZ/T7SpLeXnezQeuu5o=;
 b=nDQHUIHAhuXbaDeae73hephp3n7/DmqqG6ZOD0gdzLY1FQWnZtcoC01B0lXOcyTlNo
 h2YNOgwgfNsznDq6I1nNOOOm4cnN3N4n0T8TycmGLk6NzoYUGotD0kvUfoBZG2NHidns
 zXv38XwUL7WJ1i/imCx0B58U6TKAAn3VwvQ1b1CH/0rKj3oJs2dAqPknhDLl5nENpUQt
 jGBBYHOWnEEKYVzg3H4p4hblXcyi/IyNCveBj5fVE6d5bscRfQDHGgkssAVDkT9LohuS
 Q7BSf3z6/fMCyjXqqW08DS3VfmbP0RjMt0SWQjwLhRG9ohlQQ+X+afehYCR1wXTWq4mC
 W8zw==
X-Gm-Message-State: AOJu0YyqJFOGzVg/abZ49g6MxdYSsCHEPI3lLudgKVNZhTKb9tuOICyl
 5xgh9q2ViMkcwgsiTcwUBvAOo4PKqJ36H76mEhzVz+0kdr5WtliYoQKYYM/FRam7Tc766FVfFmA
 t/VJkC8hmXc2x/Go=
X-Received: by 2002:a05:6000:1ac7:b0:32d:d848:8efd with SMTP id
 i7-20020a0560001ac700b0032dd8488efdmr24664958wry.57.1699282282217; 
 Mon, 06 Nov 2023 06:51:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtBQ+VxdvBkTotsPp1WPEaGs3w9XIb+NUjUP4BCK6/+69gW0g5SUdr3fJlQGnnsWkHFzvCUQ==
X-Received: by 2002:a05:6000:1ac7:b0:32d:d848:8efd with SMTP id
 i7-20020a0560001ac700b0032dd8488efdmr24664944wry.57.1699282281949; 
 Mon, 06 Nov 2023 06:51:21 -0800 (PST)
Received: from ?IPV6:2003:cf:d718:8590:77de:e1fd:a4df:d080?
 (p200300cfd718859077dee1fda4dfd080.dip0.t-ipconnect.de.
 [2003:cf:d718:8590:77de:e1fd:a4df:d080])
 by smtp.gmail.com with ESMTPSA id
 r7-20020adff107000000b0032db8f7f378sm9754540wro.71.2023.11.06.06.51.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 06:51:21 -0800 (PST)
Message-ID: <0978d91f-a626-4316-81a3-15b77ca4ba7c@redhat.com>
Date: Mon, 6 Nov 2023 15:51:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] block: Temporarily mark
 bdrv_co_get_allocated_file_size as mixed
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Jo=C3=A3o_Silva?=
 <jsilva@suse.de>, Lin Ma <lma@suse.com>, Claudio Fontana <cfontana@suse.de>,
 Dario Faggioli <dfaggioli@suse.com>, Eric Blake <eblake@redhat.com>
References: <20230609201910.12100-1-farosas@suse.de>
 <20230609201910.12100-5-farosas@suse.de>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230609201910.12100-5-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 09.06.23 22:19, Fabiano Rosas wrote:
> Some callers of this function are about to be converted to run in
> coroutines, so allow it to be executed both inside and outside a
> coroutine while we convert all the callers.
>
> This will be reverted once all callers of bdrv_do_query_node_info run
> in a coroutine.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>   include/block/block-io.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


