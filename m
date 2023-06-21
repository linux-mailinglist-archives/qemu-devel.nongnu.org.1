Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C61737C7C
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 09:45:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBsWi-00005y-4X; Wed, 21 Jun 2023 03:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qBsWe-00005g-8K
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 03:45:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qBsWZ-0006dz-0D
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 03:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687333505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q2Y0DHe95gzha0BXTq/2NYHLJzQWCWd+MtyjHtcPFKs=;
 b=EBa0RZi4orJeTbMXGrTOoBKU4z3n6BigeSFEFpb48cZYqILKNWHW8rAx0yvjIMPLPbwLkK
 nMn+JNdqFSovKcUD/UPC0Z4YpmXtTz6VvzaKcIM7s2R8kkGTmRLqjANCv7ZQbIEApOLVwz
 YQphKHpx1Y8/xrjVpr3PJ4lOE/4QoO0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-567hfL9BP62zx4nvsZImHw-1; Wed, 21 Jun 2023 03:45:02 -0400
X-MC-Unique: 567hfL9BP62zx4nvsZImHw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f8fa2ef407so21482495e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 00:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687333500; x=1689925500;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q2Y0DHe95gzha0BXTq/2NYHLJzQWCWd+MtyjHtcPFKs=;
 b=hvvhoUa/nLH0drlxwdRgVBv46490/NQ1Wh+0AJFcyf4U4hmJrxlylgq/1hzvc3TPDk
 l2UxtxPAwF/JR/3OKn5JitQGpbdX4Ce2yPYSPWn7oT5uEsZWbPRzCQ2yCq5kfTlHgZzv
 zEEZ/PJFee3Fg109ZmRk1SpC0hkDQlvwQknQ8qKq7XelKGVHXueF/9NFCgrCXFIOM+KZ
 w02h+mtWiukPBIT0ObrhRo8f9oGxTzCbU7HTG9nCTDqKyeYsh8kynhJCBMZWfeL0DL0h
 QZ+L5jhI1ObPhysdojt5yfg+tuiSPQ2fzPfapYkgW87nnKJqOgqaSwhIIG2p8HSeWPB3
 qV1g==
X-Gm-Message-State: AC+VfDz2yAeFWfOjFKJLcEC5dSoHoCe6juv3jbWJZrvgSm7ikLv0iOut
 1BTneLqOXvrESSVZmpUEXc1YSWxl036Cz3664/OcF3RJjLI+FePLd7l2cJ43wPcuhyRUfqe2Yy2
 OtloDKtjXO5WND3w=
X-Received: by 2002:a7b:ca56:0:b0:3f7:f4bc:ebe7 with SMTP id
 m22-20020a7bca56000000b003f7f4bcebe7mr10481827wml.37.1687333500327; 
 Wed, 21 Jun 2023 00:45:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ497IMAYGgBHimrehEC0aJt7UpjwpIBaRoKuV6ct/ntgXV+7V9DBi8pFFa+XphkZrKEjnFenA==
X-Received: by 2002:a7b:ca56:0:b0:3f7:f4bc:ebe7 with SMTP id
 m22-20020a7bca56000000b003f7f4bcebe7mr10481817wml.37.1687333500015; 
 Wed, 21 Jun 2023 00:45:00 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 f20-20020a7bcd14000000b003f7f2a1484csm4243858wmj.5.2023.06.21.00.44.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 00:44:59 -0700 (PDT)
Message-ID: <f219acb4-6422-229d-cc94-55ca16656252@redhat.com>
Date: Wed, 21 Jun 2023 09:44:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [qemu-web PATCH] include Dockerfile used to proxy qemu.org to
 gitlab.io
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230616120829.35011-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230616120829.35011-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 16/06/2023 14.08, Paolo Bonzini wrote:
> The server configuration used to actually publish qemu-web.git
> to qemu.org together with the sphinx documentation, right now,
> is hidden in the machine that runs qemu.org.
> 
> Include it in the qemu-web.git website for documentation purpose,
> in the format of a Dockerfile that you can use to run your own
> qemu.org website.
> 
> Note: this container is not yet in use, but it is already live
> and can be tested by adding
> 
> 20.218.253.93   qemu.org www.qemu.org git.qemu.org qemu-project.org www.qemu-project.org git.qemu-project.org
> 
> to your /etc/hosts file.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   container/Dockerfile         |  6 ++++
>   container/README             | 31 +++++++++++++++++++++
>   container/conf.d/git.conf    | 13 +++++++++
>   container/conf.d/noname.conf | 11 ++++++++
>   container/conf.d/ssl.conf    |  1 +
>   container/conf.d/www.conf    | 54 ++++++++++++++++++++++++++++++++++++
>   6 files changed, 116 insertions(+)
>   create mode 100644 container/Dockerfile
>   create mode 100644 container/README
>   create mode 100644 container/conf.d/git.conf
>   create mode 100644 container/conf.d/noname.conf
>   create mode 100644 container/conf.d/ssl.conf
>   create mode 100644 container/conf.d/www.conf


Acked-by: Thomas Huth <thuth@redhat.com>


