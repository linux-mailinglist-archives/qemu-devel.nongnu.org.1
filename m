Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2117BB5F3
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:08:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoigD-0001YY-Vc; Fri, 06 Oct 2023 07:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qoig4-0001Wb-M6
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:07:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qoig2-00077V-JR
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kflegMjnqCQUoAJNfhGaCAFZAPkne5zzHSYhc3BwE1U=;
 b=Nxb5QoOGw6zW3zy+OUIFRKih3Qtcp3ooqBkW0c7WZ4mM+ZD0yC6g9ECxhR5iJY+XH5XkCs
 QQQey6N0nOvXiFXUA3OVy4qlTPLzsoZ0zcbAEbICb+Yf5Bbwpq9S3griaPlCQv6NO5oI8f
 gV0+vhYqA4bD0dDwTQPceLtVTRPHRTQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-QeTytZw_PvOysDOE3P48uQ-1; Fri, 06 Oct 2023 07:07:24 -0400
X-MC-Unique: QeTytZw_PvOysDOE3P48uQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9a1cf3e6c04so169326066b.3
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590443; x=1697195243;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kflegMjnqCQUoAJNfhGaCAFZAPkne5zzHSYhc3BwE1U=;
 b=jI7roi3/UhHIND8AOEjg4mjTvYdkIJKfzGsbswKlP42KggF82i3EXEpjg0sD0IN26D
 caNZh/Pj3q7TT7yXyOOF9K2xcZxwJz2RbhdBSLaenmitfqMwXVHrtjfy6xDirHwQupYO
 qUOLNabCNWU8eylvI8sLjGyoUGorDtyb3NAWFgajW9YgR8mCvnPlrWjca5kld+kEvOCF
 XcWDBqbVzFucP+KwpJj7s9+NCyXzDJ9rzxohcHx7DKkbxghXH4JYjhD7T1J+uqtSvuNu
 sO/g+TlLu/lC6AQWhGXg4WionymgzlLFJbGkwe6IFYjSDb6a4rbvKQWdDQyLFDPIUUwX
 0Yag==
X-Gm-Message-State: AOJu0YzAvcQOGUV/79vmFuSzNPmIx6TSKQdGiSzURJ3tpD5gvTkuD/Qb
 r3AxwFqBUpuyaq2HvVgnj4saYJO5qTu4zQ8mDiiZCc019VOhPXK3B46hg46C7y2OxqRjwWEornz
 pnDkKBff6+G01tDU=
X-Received: by 2002:a17:906:768e:b0:9b2:f38d:c44b with SMTP id
 o14-20020a170906768e00b009b2f38dc44bmr6850924ejm.24.1696590443002; 
 Fri, 06 Oct 2023 04:07:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGprpfizTI3haeikC8sLJat5R5/B75M+prWe3vYir/bF82wnr0X3GmzR7fWaQLkhW21olFHvQ==
X-Received: by 2002:a17:906:768e:b0:9b2:f38d:c44b with SMTP id
 o14-20020a170906768e00b009b2f38dc44bmr6850918ejm.24.1696590442711; 
 Fri, 06 Oct 2023 04:07:22 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-27.web.vodafone.de.
 [109.43.176.27]) by smtp.gmail.com with ESMTPSA id
 rv18-20020a17090710d200b0099364d9f0e6sm2685019ejb.117.2023.10.06.04.07.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 04:07:22 -0700 (PDT)
Message-ID: <e709856f-2815-5613-1641-8efb87aa87f8@redhat.com>
Date: Fri, 6 Oct 2023 13:07:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/5] linux-user/syscall.c: clean up local variable
 shadowing in TARGET_NR_getcpu
Content-Language: en-US
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
References: <20230925151029.461358-1-laurent@vivier.eu>
 <20230925151029.461358-5-laurent@vivier.eu>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230925151029.461358-5-laurent@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.797, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 25/09/2023 17.10, Laurent Vivier wrote:
> Fix following warnings:
> 
> .../linux-user/syscall.c: In function 'do_syscall1':
> .../linux-user/syscall.c:11180:22: warning: declaration of 'cpu' shadows a previous local [-Wshadow=local]
> 11180 |             unsigned cpu, node;
>        |                      ^~~
> .../linux-user/syscall.c:8963:15: note: shadowed declaration is here
>   8963 |     CPUState *cpu = env_cpu(cpu_env);
>        |               ^~~
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   linux-user/syscall.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)


Reviewed-by: Thomas Huth <thuth@redhat.com>


