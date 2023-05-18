Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D437084D9
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 17:28:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzfYK-0002Gu-K8; Thu, 18 May 2023 11:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzfYJ-0002C8-00
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:28:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzfYH-000460-Ew
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684423703;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+NpevbFIAj2Z7u8KYUyYjpw7m0wCftQlVsSEjAdWNE8=;
 b=AAM3vCmDXcbRn0GXX1UeOPHl3dWKhSO5SwdjA16a863NFHcAxKIE2qUWbyLh5MbfeUbhYY
 tiSGQro3hl6uvkDofEprDbBSfZmYMYIhS4bTa5V9BAK7YrT81YZ1DPoXE2UF0vQuNcfkBz
 6Qdr7GTLSzj/K1FuEDVxanYcUh4DGUo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-U9Ep3-JbMeidM8XQ8PzlAw-1; Thu, 18 May 2023 11:28:22 -0400
X-MC-Unique: U9Ep3-JbMeidM8XQ8PzlAw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f41ce0a69fso8779165e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 08:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684423701; x=1687015701;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+NpevbFIAj2Z7u8KYUyYjpw7m0wCftQlVsSEjAdWNE8=;
 b=GXk6P9Z0hj/thJGjWVdeW7J5WYCtwi69mItQWAoyZVt968OKVEsa80e3ahYIhKSyx2
 IyA5cuGJTWog4HlqNVNxYA/Amvd9gg1zU9YUkMM+nnQofI2yhb6D3RgJoiaBKAb8ldr+
 JqwxebJ8o5MkpaVa9z4OwsRb0ZwwmqExXalgn1lIs1MQuBZn4XylYX5LIwKk6Lfcek+O
 XZsqjocTc30jZyq3JidCPsezO8hgDPMXqCPJ5WhDfPstOoBFSv2tGpVL8bKc7BxztCPA
 GhxSugRklyc1GjWZgEFvBWsP7A6yG9YGrbjJ9w/Q74QYcmwNTcN14qMf+Rt+aNyCGaRC
 ZJ9g==
X-Gm-Message-State: AC+VfDw+pWsIAj7EiS0NG0FebF1DzFoNwHXBjDH//+QackAxv8vZgYdP
 3nGNtsA9p2EjTg1xRpE+uxttM7Z3XNoJn91SE/pqxifH/8Y4zZ8tcyKU48Tp5zi3wEKA4O15ZPx
 K0TEmrLXA4M7bNso=
X-Received: by 2002:a7b:c3c4:0:b0:3f1:75ae:1cfe with SMTP id
 t4-20020a7bc3c4000000b003f175ae1cfemr1820780wmj.7.1684423700979; 
 Thu, 18 May 2023 08:28:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ61j0I7srj77qx2GVVchZxAvEUMzhSZcifVNCodlN+V2f4lq3jBdbIhN8/SoYtpV3bGAsY12A==
X-Received: by 2002:a7b:c3c4:0:b0:3f1:75ae:1cfe with SMTP id
 t4-20020a7bc3c4000000b003f175ae1cfemr1820772wmj.7.1684423700743; 
 Thu, 18 May 2023 08:28:20 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 l2-20020adfe582000000b0030632833e74sm2578760wrm.11.2023.05.18.08.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 08:28:20 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: Daniel =?utf-8?Q?P=2EBerrang=C3=A9?= <berrange@redhat.com>,  "Wang, Lei4"
 <lei4.wang@intel.com>,  "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>,  "leobras@redhat.com"
 <leobras@redhat.com>
Subject: Re: [PATCH] multifd: Set a higher "backlog" default value for listen()
In-Reply-To: <DS0PR11MB6373526303940FC5D9892BABDC7F9@DS0PR11MB6373.namprd11.prod.outlook.com>
 (Wei W. Wang's message of "Thu, 18 May 2023 15:17:08 +0000")
References: <20230518085228.172816-1-lei4.wang@intel.com>
 <DS0PR11MB6373D659BCA67BD75D8ECC5DDC7F9@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZGYaOu3F3hsiPj5N@redhat.com> <87a5y1dd55.fsf@secure.mitica>
 <DS0PR11MB6373526303940FC5D9892BABDC7F9@DS0PR11MB6373.namprd11.prod.outlook.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 18 May 2023 17:28:19 +0200
Message-ID: <87sfbtbqwc.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

"Wang, Wei W" <wei.w.wang@intel.com> wrote:
> On Thursday, May 18, 2023 8:43 PM, Juan Quintela wrote:
>> 
>> 
>> Are you using -incoming defer?
>> 
>> No? right.
>> 
>> With multifd, you should use -incoming defer. 
>
> Yes, just confirmed that it works well with deferred incoming.
> I think we should enforce this kind of requirement in the code.
> I'll make a patch for this.

Actually, we should deprecate everything except defer.

Later, Juan.


