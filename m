Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9BA7497A3
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 10:44:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHKaJ-0005q1-2o; Thu, 06 Jul 2023 04:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qHKaH-0005pi-B8
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:43:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qHKaG-0005pv-0V
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688633007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yB5Yw0D45TiK9cjbePr8i4dzc070lQhTa2ZJmTS/vrQ=;
 b=cwaE9U9PaAV0cT5HPY7TR15NV9QO/kBIpqupuKI3zWNZtQo3UcpymMjLox4JkCQKjInv1e
 7sSz2LNEJafqTIVFyGw5N59XwG7tJFR+otCqvGQvHAhnU3n+8JpjJImRaesbZhrks+Dv5M
 fzNh10D3kAxK4lnJKhQRB8+MOSJ+hMs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-NOdigaffNzmhqJ-N-0H7lw-1; Thu, 06 Jul 2023 04:43:25 -0400
X-MC-Unique: NOdigaffNzmhqJ-N-0H7lw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-635325b87c9so6776656d6.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 01:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688633005; x=1691225005;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yB5Yw0D45TiK9cjbePr8i4dzc070lQhTa2ZJmTS/vrQ=;
 b=JR1zTccfPVJBFSlUa6Y0rw+udHifDnIlaCz30LQ078CQNIoNNDZN1gmVCeA/Le5AoT
 tf63coz7KU+9eLossbx2fMPvxskbXv4TgXp0MmobBhpL5c2QFfg50/0c7PHevvENt567
 pqbDuLn+TeTJu8DCxccaY190MIU7mFGZHR4GMkptFm6GkDFJOevYG74ojw4xl0O/H2Lv
 ROHFtyUF6KkpRkmzPlel4RKcQMjE/541hoU/meOHxV8r9abRRDhK6svtqPAji8xDJLTq
 C5KE89A54yAxm9ZUZfCaTQ74TYlUu2fPrqly4EIWL6bvr7UJAowX5/pcIXnqdgg60tzv
 WL7g==
X-Gm-Message-State: ABy/qLYlwYhpjdOeb6KkMH2LfGw/21kH6XS9iTFAbpw5B4GIh6IqyXAR
 i06GUw02jbxjlSLvCjDQ4SjR1e/DqBxmadFmnVYH84zrQ4W9EDU3gVpTgh/TDNy7uE5g6XKcUS7
 sNGGu9OdflVL8mDQ=
X-Received: by 2002:a0c:ab09:0:b0:635:4693:e400 with SMTP id
 h9-20020a0cab09000000b006354693e400mr934768qvb.7.1688633005351; 
 Thu, 06 Jul 2023 01:43:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGeKx99kjH7v4k7vvdPQngilG90nIg7mqLdkZop5RdFGjXJxTf37QmwGjdzJnAqhuHa+gIQXg==
X-Received: by 2002:a0c:ab09:0:b0:635:4693:e400 with SMTP id
 h9-20020a0cab09000000b006354693e400mr934752qvb.7.1688633005124; 
 Thu, 06 Jul 2023 01:43:25 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-114.web.vodafone.de.
 [109.43.176.114]) by smtp.gmail.com with ESMTPSA id
 p8-20020a0ce188000000b0063757aea986sm623355qvl.28.2023.07.06.01.43.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 01:43:24 -0700 (PDT)
Message-ID: <874f9c82-6be8-2433-1bc2-4df13def8957@redhat.com>
Date: Thu, 6 Jul 2023 10:43:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/5] migration: migrate 'inc' command option is
 deprecated.
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>
References: <20230622195019.4396-1-quintela@redhat.com>
 <20230622195019.4396-3-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230622195019.4396-3-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 22/06/2023 21.50, Juan Quintela wrote:
> Set the 'block_incremental' migration parameter to 'true' instead.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>   docs/about/deprecated.rst |  7 +++++++
>   qapi/migration.json       | 12 ++++++++++--
>   migration/migration.c     |  6 ++++++
>   3 files changed, 23 insertions(+), 2 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


