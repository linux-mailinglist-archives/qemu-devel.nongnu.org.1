Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F241C7824A4
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:40:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXzUm-00025F-2x; Mon, 21 Aug 2023 03:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzTH-0000Io-Bg
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:37:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzTB-0006G6-Rv
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692603421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HKd/fS0zE4NUSvk5ihvAP1Gv+5awneT/3pSvqy3s0X8=;
 b=fDabOaq3WRNJXf2tz33dKea2soQWCZMyvWgjserbErdSSDrRAaLTLk1mkz4gYTD8iV3XFp
 AWPqoQJfHuVQKswl5I6lJLiWgaRB2paE4/FzRpeH5/6H+UcSk+Dqtwk15Z+he2of2/t2OS
 WiaXxxZR89jSTxwZkoSrnZ6/BnhBmSQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-Zx78lajpNQyJQXWfKdt3lw-1; Mon, 21 Aug 2023 03:35:31 -0400
X-MC-Unique: Zx78lajpNQyJQXWfKdt3lw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe1d5e2982so20138595e9.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692603330; x=1693208130;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HKd/fS0zE4NUSvk5ihvAP1Gv+5awneT/3pSvqy3s0X8=;
 b=a69tbVQT85OFEtzXcXDkobYIG8INYa6uTi2O3Y3LEIzVVo1f6UelDpw6UFPDO4nnzP
 8KbBRBrqmg5q5ZtBPfYcC0YbRLOdaan/UbfeEFD5/tKj6MCKAYpeq9bZX6sNQtljCuL2
 tRWBvm32/pI3XnLAsfDS7oE46cm+s+xJcNvpi+NlvJ0xEt67VQALeUPosVp2WC9WjUPi
 rB2+coYnJ7qDfg9kh+PetHH+MQcpJmVZrcRnE3VEQXkXbUDSTvMewZ6KD6mGl9YwpvcI
 0sOu/JP32qLiCv2jkhMMJwLj85eFKzUHyV13vqj+ewOn7TLFw+7gtzpHZ0TEFbgd04ht
 B5eA==
X-Gm-Message-State: AOJu0Yy8a7t1i7qspMlWxKhSGqh5g5HPC3Muc7srE1bwUBP9sCouMekE
 CtKi4wHxBUmn7HpwqoSzGz2T3/FSSHSZG93uORhBfuOB2AgcS0W5nac+iD2GsjZ8f/w1qlQqV19
 oo9gGvVdQjlaEVko=
X-Received: by 2002:a5d:44cf:0:b0:313:f33c:24c4 with SMTP id
 z15-20020a5d44cf000000b00313f33c24c4mr3819797wrr.39.1692603330164; 
 Mon, 21 Aug 2023 00:35:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYcO5DT9vHjP6KZhPy1DOI6atYvV2lTqWbM/NS5hndMnS26xFkywo2g/hhkgLNd/+E3ZLI1w==
X-Received: by 2002:a5d:44cf:0:b0:313:f33c:24c4 with SMTP id
 z15-20020a5d44cf000000b00313f33c24c4mr3819789wrr.39.1692603329953; 
 Mon, 21 Aug 2023 00:35:29 -0700 (PDT)
Received: from [192.168.149.106]
 (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
 by smtp.gmail.com with ESMTPSA id
 w4-20020adfcd04000000b00317df42e91dsm4615957wrm.4.2023.08.21.00.35.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:35:29 -0700 (PDT)
Message-ID: <0996be68-618d-0451-4764-f95d898389b7@redhat.com>
Date: Mon, 21 Aug 2023 09:35:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 19/21] block: Mark bdrv_root_unref_child() GRAPH_WRLOCK
Content-Language: de-CH
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, pbonzini@redhat.com,
 vsementsov@yandex-team.ru, qemu-devel@nongnu.org
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-20-kwolf@redhat.com>
From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <20230817125020.208339-20-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eesposit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.279, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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



Am 17/08/2023 um 14:50 schrieb Kevin Wolf:
> Instead of taking the writer lock internally, require callers to already
> hold it when calling bdrv_root_unref_child(). These callers will
> typically already hold the graph lock once the locking work is
> completed, which means that they can't call functions that take it
> internally.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>


