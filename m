Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC67E723EEB
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 12:08:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Tba-0007e8-Fg; Tue, 06 Jun 2023 06:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6TbX-0007dx-28
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:07:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6TbV-0003Sz-2Y
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686046069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dfQMVc6p26pVHzkRqiVhpQh6RJn3kmzPMcC/O2y7Jlo=;
 b=Y/u+jd/W8Kwevf0/ee6TnXOn6cRbESBe+bMqjvTOuh7iOEESMB4cE5rrIgq5Oqu4A5lPBy
 Ciq7N4QV6vcGZJPMTw5gvocvvMYpk6Q0/THogDQsPAdFG68ZzB/HneqFTc7ytzUsO41ger
 WMwV5QPbOsfzYNUnK1CO9hFVwtZTjCA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-KU7su2i-O068eQ7uRI5lHQ-1; Tue, 06 Jun 2023 06:07:48 -0400
X-MC-Unique: KU7su2i-O068eQ7uRI5lHQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f739a73ba4so11096555e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 03:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686046067; x=1688638067;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dfQMVc6p26pVHzkRqiVhpQh6RJn3kmzPMcC/O2y7Jlo=;
 b=VethMaInmxmAUkZw90tgDyrqcthoh5X0UGaKvK/Z1R17+pkk9IvN0Xl3GMyHlr+bq9
 pvIDRuli8e01C2jsvmto3TcrIMbkmAdb6s8sQkm1ObQN062EqkaXmhlLAbMA2PF1lp6m
 KqjD3QqDjn5ZZKhaL7Xz4qk1K+XkZ5oZ1FsTCbQismGWgFKj/pj0gHDxE19WWidPmgZd
 NQmFuJ3dMUEmZD1EXOvpnsNgIS4A/ebC7Y3Cm39yqlGv0sFaPxUtXY+I5blK7UStadeQ
 nkzpZDixuFjubzavSsyEKOXmL64RtpFTMPIgLpJxqaDczF0Z1qKSZuMGuPyy9L7Hzjgq
 SJEg==
X-Gm-Message-State: AC+VfDw0xRMErGYfubM9guVRp9YuCXF3bAlNu36N2MXXu0eEXDH8XLmq
 smm+u8AwZcFf2YQ+iCNN8s30z/IPuUSkm7IaVIJOFJwMbans8grg3n4ZOVchSgowGLg9M8+SLse
 A7O6m9pvBkMxa9XY=
X-Received: by 2002:a7b:c30c:0:b0:3f7:310a:3ffc with SMTP id
 k12-20020a7bc30c000000b003f7310a3ffcmr1683948wmj.5.1686046067256; 
 Tue, 06 Jun 2023 03:07:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6GaBT9ANxabqQW4wxuYyP1rX5RR7nEg2gFCL3H+2jkKTX+xQ5aD3ujrn7oxGkF1rCgkoyr6A==
X-Received: by 2002:a7b:c30c:0:b0:3f7:310a:3ffc with SMTP id
 k12-20020a7bc30c000000b003f7310a3ffcmr1683930wmj.5.1686046066864; 
 Tue, 06 Jun 2023 03:07:46 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-42-114-92.web.vodafone.de.
 [109.42.114.92]) by smtp.gmail.com with ESMTPSA id
 u12-20020a05600c00cc00b003f7678a07c4sm6781600wmm.29.2023.06.06.03.07.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 03:07:45 -0700 (PDT)
Message-ID: <7e632e82-06e0-7283-d57c-7a58d8d00c01@redhat.com>
Date: Tue, 6 Jun 2023 12:07:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 06/10] configure: move SLOF submodule handling to
 pc-bios/s390-ccw
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com
References: <20230605095223.107653-1-pbonzini@redhat.com>
 <20230605095223.107653-7-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230605095223.107653-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 05/06/2023 11.52, Paolo Bonzini wrote:
> Move the handling of the roms/SLOF submodule out of the main Makefile,
> since we are going to remove submodules from the build process of QEMU.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   .gitlab-ci.d/buildtest-template.yml |  2 +-
>   configure                           |  7 +++----
>   pc-bios/s390-ccw/Makefile           | 11 +++++++++++
>   3 files changed, 15 insertions(+), 5 deletions(-)

Acked-by: Thomas Huth <thuth@redhat.com>


