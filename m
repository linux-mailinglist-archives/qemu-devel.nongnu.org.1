Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F157657FF
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 17:49:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP3E8-00027o-FV; Thu, 27 Jul 2023 11:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qP3Du-00027G-8U
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:48:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qP3Dq-0006A3-48
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690472893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dg4v6HIzEug8BPUKUwOvp1Dwb65OvfEguNr2kCvxNK8=;
 b=dHHARodoHXrU3qRZTfhVOUgk21L7p2x0rKDQYJla6cTojlADE7aEpSKy39X9RSmSv1Q70B
 r47G1hA/+7zY0yXlldMHUSOF+c7TNtQGi9IPNDOINRWuvYvbIuRhqpqZnvdg4ydJgZ8MJW
 lDYpNK1UXhg7XMOwh7yZJmkAwdmDhyw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-sHj8RQfDPTGvweq0IV8m0Q-1; Thu, 27 Jul 2023 11:48:11 -0400
X-MC-Unique: sHj8RQfDPTGvweq0IV8m0Q-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-52256d84ab1so700444a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 08:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690472890; x=1691077690;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dg4v6HIzEug8BPUKUwOvp1Dwb65OvfEguNr2kCvxNK8=;
 b=c3t6o4Rh8LZjZmoUOvxc+UvcetFjDGglrTKme8MSPWDStXOnMtrihwd1u3AJfpNZDu
 Cg/ZR522QmTaE+w//cXhXYW3iToH7a+Hba9E5YNi2xwuZdAnjAY/WT1qmLQsRSfks+It
 oO9jqZpLZKsBDffa3buiau+la7JmOMcHuGaPVvCT5Hdm8Rmx6xmiuh/bD7YT7+2i/3mk
 5sry8N+Wzvy4ly7g+s9u3hLeZpXK5/rMVrNNoDQPBuOGzNjTMUt+AZIA37KK9aJhIQBs
 /EYJmih3Vv8k773TNFImoDnzE+iQF8C8UKGy3o7CHxjMlTv84D8n8bcwmNmqV7b6wwAC
 2jCw==
X-Gm-Message-State: ABy/qLY8X3ZhSxkBi1Y6+bAzcpbyNQGKrUHTpxTZfM02SMMXgJljZvbR
 HRIWhCpQJIdZhK34c1eptPHa12nfCcF4RIMKJFE7KFF91UX7mnF32v5N7Cb0iMtkP0NymLWoEx7
 cAkv9dlz9wQZWr24=
X-Received: by 2002:aa7:d412:0:b0:522:30cc:a1f4 with SMTP id
 z18-20020aa7d412000000b0052230cca1f4mr2352538edq.0.1690472890540; 
 Thu, 27 Jul 2023 08:48:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGB93IRyQrMmIt3dt9EaNcxbVt2Oga/qJHHLTlLS/cX17ALsShVgRx94GRsuHGvOJQeSp9pIg==
X-Received: by 2002:aa7:d412:0:b0:522:30cc:a1f4 with SMTP id
 z18-20020aa7d412000000b0052230cca1f4mr2352526edq.0.1690472890270; 
 Thu, 27 Jul 2023 08:48:10 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 l4-20020a056402124400b00522274c3775sm775041edw.68.2023.07.27.08.48.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 08:48:09 -0700 (PDT)
Message-ID: <1f16a047-b4a4-0fb0-9b59-7a0a7bb16d21@redhat.com>
Date: Thu, 27 Jul 2023 17:48:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 8/9] fsdev: Use ThrottleDirection instread of bool
 is_write
Content-Language: en-US
To: zhenwei pi <pizhenwei@bytedance.com>, berto@igalia.com, kwolf@redhat.com, 
 groug@kaod.org, qemu_oss@crudebyte.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, berrange@redhat.com
References: <20230724100939.1022984-1-pizhenwei@bytedance.com>
 <20230724100939.1022984-9-pizhenwei@bytedance.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230724100939.1022984-9-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 24.07.23 12:09, zhenwei pi wrote:
> 'bool is_write' style is obsolete from throttle framework, adapt
> fsdev to the new style.
>
> Cc: Greg Kurz <groug@kaod.org>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   fsdev/qemu-fsdev-throttle.c | 14 +++++++-------
>   fsdev/qemu-fsdev-throttle.h |  4 ++--
>   hw/9pfs/cofile.c            |  4 ++--
>   3 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


