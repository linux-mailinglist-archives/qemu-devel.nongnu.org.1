Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D63BD7C5891
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 17:51:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqbTu-0002Aj-1Z; Wed, 11 Oct 2023 11:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqbTq-000222-Bb
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:50:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqbTo-0004U7-P0
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697039436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mRXNuw6jnlxcqKZHk0tEaLCuXgIAvdjFbYgsp8CgviY=;
 b=V7o+VjU8DmpttOhb3QTSM0RelbmjKfyNmCFvs3OL7K4f3HxvhXA6xF/JvZbopDiKmdXsRx
 iBDK96RsobPBp4ThtsAyy2cwFocpAwDh1rFYqiXZ3rMyEsmP2IyzxmpjjsKbs8vKsYxVnz
 fEHXyu3wZECv4yCkre3e7uwsBsPo1jo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-TfAubibwPQqf_pk0O1-Osw-1; Wed, 11 Oct 2023 11:50:34 -0400
X-MC-Unique: TfAubibwPQqf_pk0O1-Osw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-65cfb5ff28aso72740296d6.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 08:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697039434; x=1697644234;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mRXNuw6jnlxcqKZHk0tEaLCuXgIAvdjFbYgsp8CgviY=;
 b=Ap19cwLZdX0Dk7qY/GVFkKZDMsaoymBd95Wk2+2cO8F3gYNI3GnZc3NalsB3fABXZF
 QAPOqfBT3chSfp5nMZvbRYvzJgn1WhWr5/D7Dp2YqTY6f/rF5illny8vC4jlZ8vQAOpZ
 +IOhfqnDKl/DOzaOpi+LcX+UwyavkJHoPVPv3n/EIgN6Dp/vX/GKq37LuKbX1+kSND2k
 RbvUa7I7ScqD5lES48/lxWcav2B63WnJNF3HaQteqBEDqb1ENv1Fy2oOoDARV/kpGHtF
 UUR6uokdAh7a9gzPP24hS6irzFLYoCJOGjBEU2/d/KtuzPGg0I7AJAJzt0X7n4OVJ1Yr
 kr5g==
X-Gm-Message-State: AOJu0YzEdjjBLieUGwM6T6aSNVA+iNYvwcU5/ptBlSnoiJZuszNkBvIf
 oFJL6zrO5Qn3ZMsi+KBKcBuak362ltgb2FW2QT1hhdZjywK78utRe8Dpw1mw73Ng5BHHBBhySaD
 Y0KIUI5wgEpA7JA4=
X-Received: by 2002:a0c:c98a:0:b0:649:c4f:8d81 with SMTP id
 b10-20020a0cc98a000000b006490c4f8d81mr20206363qvk.5.1697039434421; 
 Wed, 11 Oct 2023 08:50:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSkMBG68wVdQ4SY2MxLKHE6cmWzHz0MGZpRKtuFrRWRxu+YMNf0OFCGsXQia+zkIKVgdvoNg==
X-Received: by 2002:a0c:c98a:0:b0:649:c4f:8d81 with SMTP id
 b10-20020a0cc98a000000b006490c4f8d81mr20206346qvk.5.1697039434164; 
 Wed, 11 Oct 2023 08:50:34 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-176.web.vodafone.de.
 [109.43.176.176]) by smtp.gmail.com with ESMTPSA id
 d9-20020a0cf0c9000000b00646e0411e8csm5762527qvl.30.2023.10.11.08.50.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 08:50:33 -0700 (PDT)
Message-ID: <1e60c9b1-ed38-4653-9c1e-10e0b2c8973e@redhat.com>
Date: Wed, 11 Oct 2023 17:50:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] tests/qtest/migration: Introduce
 find_common_machine_version
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20231006123910.17759-1-farosas@suse.de>
 <20231006123910.17759-7-farosas@suse.de>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231006123910.17759-7-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 06/10/2023 14.39, Fabiano Rosas wrote:
> When using two different QEMU binaries for migration testing, we'll
> need to find what is the machine version that will work with both
> binaries. Add a helper for that.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   tests/qtest/migration-helpers.c | 24 ++++++++++++++++++++++++
>   tests/qtest/migration-helpers.h |  2 ++
>   2 files changed, 26 insertions(+)
> 
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index be00c52d00..8512134b92 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -180,3 +180,27 @@ void wait_for_migration_fail(QTestState *from, bool allow_active)
>       g_assert(qdict_get_bool(rsp_return, "running"));
>       qobject_unref(rsp_return);
>   }
> +
> +char *find_common_machine_version(const char *mtype, const char *var1,
> +                                  const char *var2)
> +{
> +    g_autofree char *type1 = qtest_resolve_machine_alias(var1, mtype);
> +    g_autofree char *type2 = qtest_resolve_machine_alias(var2, mtype);
> +
> +    g_assert(type1 && type2);
> +
> +    if (g_str_equal(type1, type2)) {
> +        /* either can be used */
> +        return g_strdup(type1);

If you remove the g_strdup() in the previous patch, you can also get rid of 
the g_strdup() and g_autofree in this function here (and change the return 
type to "const char *".

  Thomas


> +    }
> +
> +    if (qtest_has_machine_with_env(var2, type1)) {
> +        return g_strdup(type1);
> +    }
> +
> +    if (qtest_has_machine_with_env(var1, type2)) {
> +        return g_strdup(type2);
> +    }
> +
> +    g_assert_not_reached();
> +}
> diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
> index 009e250e90..fc7f693fb6 100644
> --- a/tests/qtest/migration-helpers.h
> +++ b/tests/qtest/migration-helpers.h
> @@ -33,4 +33,6 @@ void wait_for_migration_complete(QTestState *who);
>   
>   void wait_for_migration_fail(QTestState *from, bool allow_active);
>   
> +char *find_common_machine_version(const char *mtype, const char *var1,
> +                                  const char *var2);
>   #endif /* MIGRATION_HELPERS_H */


