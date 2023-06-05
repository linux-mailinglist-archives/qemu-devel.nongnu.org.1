Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9887221B8
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 11:07:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q66Aw-00076I-Tx; Mon, 05 Jun 2023 05:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q66Al-00070s-El
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:06:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q66AZ-0006vU-RR
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685955990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bDFt+FcAQOj/227ISjZJosTCfnGxpDdpQgOXq6qVH7I=;
 b=JeCwzmpS/1mZsRs5/NdKKVUaP8h+mRIt91pwNvwL2rCTZAhnNUC07EWUcw0dTmdt4hsN9W
 fbcWwmhbbKrSGwJEwbdkiW45zelwBjc3JSwDL5Xy6i4sVrEbfoCY/VWzKd8gNdIxPA97of
 /7yml7E1c8kaizQeW+3rVoWm3UkY5R8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-QGQlGgRlPoeX4fVE6v7_IA-1; Mon, 05 Jun 2023 05:06:26 -0400
X-MC-Unique: QGQlGgRlPoeX4fVE6v7_IA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-976c92459cbso200150666b.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 02:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685955985; x=1688547985;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bDFt+FcAQOj/227ISjZJosTCfnGxpDdpQgOXq6qVH7I=;
 b=QMo00fz7tioxbf/SulASbxFUXl4lfp9wfAs6td0Mn9Cwey/GQGbeJi1Zv2eE00lOzh
 9e+qT3+tTTqGLsmpVd7B4PNXDI4pQ7/bn83XQGZGK3Bg6xcJLGs7ERZAIC0ZN3K84jlC
 ze9IfHtFPHIN0+jNh3ME40p3PMcLXGJEWodepXj3dwG+iAVNqHzTdN0LO8RtQFq8nUWw
 08sD2qUaeQnjpvyfEWLQw97/QedX1eeMvlQwUEwLlu47B8Y2/lERGO6S1WU3iZJo6V0v
 5flOO0TvhG4803KhyRSbnyHxi1VWzSKhWj+pEvdPK2vihEeDVxjJw4+AYnCb0zDU94ij
 RQpQ==
X-Gm-Message-State: AC+VfDype425FzQCL8v/ix+6TTNou9TXOaKq8ZGLBE2XsvCN7c5gfDSx
 6B8tJkhZBxpnOp1BL5W1apCFz92KXR1w5X5loIJCdjA87/TNqvthSpRVR6w62uw0wy/KqywSAyk
 YpbOEnGir2zS/uPjy3aftQxU=
X-Received: by 2002:a17:907:1688:b0:96f:7b4a:2909 with SMTP id
 hc8-20020a170907168800b0096f7b4a2909mr7337929ejc.26.1685955985311; 
 Mon, 05 Jun 2023 02:06:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6+fnRA8/x9AbjK50V7k61O9qRjINc4d74/5NLoPY3lUF61EU6ZWKVfsdDBBVjrbvzMwv/xEg==
X-Received: by 2002:a17:907:1688:b0:96f:7b4a:2909 with SMTP id
 hc8-20020a170907168800b0096f7b4a2909mr7337919ejc.26.1685955985065; 
 Mon, 05 Jun 2023 02:06:25 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c?
 ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.googlemail.com with ESMTPSA id
 oy8-20020a170907104800b0096b4ec45e10sm4021178ejb.139.2023.06.05.02.06.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 02:06:24 -0700 (PDT)
Message-ID: <fbcb21e3-9544-eea2-ab5b-9bb84ac7c90b@redhat.com>
Date: Mon, 5 Jun 2023 11:06:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 11/11] Revert "graph-lock: Disable locking for now"
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, hreitz@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org
References: <20230605085711.21261-1-kwolf@redhat.com>
 <20230605085711.21261-12-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230605085711.21261-12-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/5/23 10:57, Kevin Wolf wrote:
>   void bdrv_graph_rdlock_main_loop(void)
> @@ -296,18 +276,13 @@ void assert_bdrv_graph_readable(void)
>   {
>       /* reader_count() is slow due to aio_context_list_lock lock contention */
>       /* TODO Reenable when wrlock is reenabled */

There's still a TODO here.

Paolo

> -#if 0
>   #ifdef CONFIG_DEBUG_GRAPH_LOCK
>       assert(qemu_in_main_thread() || reader_count());
>   #endif
> -#endif
>   }


