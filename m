Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFB97BB4A7
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 12:02:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoheN-000402-FO; Fri, 06 Oct 2023 06:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qoheB-0003zd-AJ
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 06:01:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qohe9-0006qL-FA
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 06:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696586484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HzzzH7zz5gKNjudKWE/9Om0HzoPAn1jIz39zE5uhn2w=;
 b=XQlHg1Hc94GsfX6rDvR9JN9DkI+YPuIFEIccxq5/yFOD7fX4UVlXoND4UXN8IzHxsdjUaO
 4IpNRJYhB3dsQf3AVU5z2EnUvOnSjpoJCcg18uiVjLS8sO4oasuR1/P5jjPPuzo3HGAAIO
 f/wPWqHBxd7g7+usP7/GqN9sZImEgLY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-ypNi0VtqMAaJQ2sOtK8X8g-1; Fri, 06 Oct 2023 06:01:13 -0400
X-MC-Unique: ypNi0VtqMAaJQ2sOtK8X8g-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-775d995f92aso189393485a.1
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 03:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696586472; x=1697191272;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HzzzH7zz5gKNjudKWE/9Om0HzoPAn1jIz39zE5uhn2w=;
 b=gBRxveN+/gHJnIZghBEN4KdgFUn59hA/IF6C2+fvrNU0OyVyYlSpKuZfsBcj8cBUS2
 rcjjQvn9jF2pIWrIKzEzx9LNtRcesTWJgb/OjQP1JpxbfWQccvvKPkThs/l+jf0hUg8l
 7VSmT3ouAqRIna3Y4VV4nQm1zGTN343gODOSXy0UgzKHjyWf9OXnCJlRfEyLrUAZqtVH
 cCftb1F8kVOubY/ET5XVlTuiGKv5RagGfYW81XMAl1QLw9dc6aiI+jTdDiDHL+kISLzk
 h1Zq1snhH5JL2/6DzZ6+W/RbxYkbBw7eh+IpFlEyzB4rascQbcCNJMJMUsCXNYimXy5N
 AM3A==
X-Gm-Message-State: AOJu0YzLGrLpIEUYod8orfw5N1mC9NIYWAogg/jDfq8WfVuu+KIEgq7T
 9m5a60UlLuDfRP8FOdoNCHrfQmsNAMd0uWqcjcFvHPTQ8vDE2nkw64gaJif6xQEVn2lfE9iXFUf
 TKoiH+VWu0k9m1+I=
X-Received: by 2002:a05:620a:4624:b0:775:9bc4:133a with SMTP id
 br36-20020a05620a462400b007759bc4133amr8507835qkb.10.1696586472582; 
 Fri, 06 Oct 2023 03:01:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSluiMt/8mzIxpxrUdPY+i4pARv/dXohelAQLKRLHcrN2fOxfiOmMWPP+vycIN+/XkSor9UA==
X-Received: by 2002:a05:620a:4624:b0:775:9bc4:133a with SMTP id
 br36-20020a05620a462400b007759bc4133amr8507796qkb.10.1696586471947; 
 Fri, 06 Oct 2023 03:01:11 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a37e206000000b00767721aebc0sm1185538qki.32.2023.10.06.03.01.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 03:01:11 -0700 (PDT)
Message-ID: <59c04c82-7cad-03ad-cdfa-8bb92ccc59b0@redhat.com>
Date: Fri, 6 Oct 2023 12:01:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/5] linux-user/mmap.c: clean up local variable shadowing
Content-Language: en-US
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
References: <20230925151029.461358-1-laurent@vivier.eu>
 <20230925151029.461358-3-laurent@vivier.eu>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230925151029.461358-3-laurent@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.219, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
> .../linux-user/mmap.c: In function 'target_mremap':
> .../linux-user/mmap.c:913:13: warning: declaration of 'prot' shadows a previous local [-Wshadow=compatible-local]
>    913 |         int prot = 0;
>        |             ^~~~
> ../../../Projects/qemu/linux-user/mmap.c:871:9: note: shadowed declaration is here
>    871 |     int prot;
>        |         ^~~~
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   linux-user/mmap.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


