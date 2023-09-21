Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 279257A946D
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 14:54:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjJ2M-0008UV-M9; Thu, 21 Sep 2023 08:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjJ0T-0006ZG-Rh
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 08:42:11 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjJ0L-000271-QR
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 08:42:08 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-529fb04a234so1031053a12.3
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 05:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695300119; x=1695904919; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hzHv5wRRxnGLl33iiUbNmV1KkzNxk+do0fTlDHKrnPg=;
 b=J5m+nXl7g5XfHNBFRl4FpofVPoRvmkMVOCDzIJssHSEDpKIpBP0kzzb2HHEx0mH64x
 anpoZNtZW7I0TrWQgAP+hDJHTqTm/nYJLcfsblrSFbThL1QHM/I2R2Jj1AkbmO1uO6Lz
 ryQKaLEFJ5UXvRhiILmBIxRXVXBVFe/K5Jy030vshDr6esoevWytc4cHBD4Q4fga0c8P
 xYhJ6YGxo7SiQqhmVHM9MLARI2NrpS6wWSN/rZgWeDUfqoZ8lMoM9SQjkOmjgjGqeR/P
 t377YFUywvH6wBRJPa7gxO5XRkTpY/L/VeniNYLdOHSa0FHQvF0462cIxKNtoaXV1HZ/
 shOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695300119; x=1695904919;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hzHv5wRRxnGLl33iiUbNmV1KkzNxk+do0fTlDHKrnPg=;
 b=FK1SMbZ9R146anHhoW2qIpKL5CuiHUzRmSXAznv+PO3nbpRG/dfjzDt50j444mTPP4
 pL1dwwCmfaX2+wBgXJD8Aanxg4QiJv0f+VnMLlLc935YntJ/8wKI1ZdpoEstZAlo/GQF
 AjZgcw4358eX7hlb+zxDj8lbW9N6C3IYN4aC0OtzfvmfJ78WwYOsR2pcS1KuNr9Tj3f4
 CFQ9/KxiT3ivUOgRVYXsYgAn+16jooqsdtGkp+kgw4CwfL+Yc+W4q1zUOZgIv7h2wXc0
 4L8oAFUbdMaCME/7I9wMD6cfTAUclU3DrZxWfkwhGUulkBzHHU/+9B6DYX4/P5P3qmMG
 axtA==
X-Gm-Message-State: AOJu0YxZNMIW/nk1iD8/GKfUvjVkT6xohmW9E3YXWL57JIBcQ32JkFJ3
 UXMHgqaey/BVnMTArQF5oAxlOQ==
X-Google-Smtp-Source: AGHT+IFq6Gkfx1rvH/W76kLaY8mfGpbiX5vLzomsHrnI36knR+WJY/4ipOIpGsVRwTRwCx55YJKgNw==
X-Received: by 2002:a05:6402:1489:b0:52b:c980:43f3 with SMTP id
 e9-20020a056402148900b0052bc98043f3mr4352474edv.28.1695300119124; 
 Thu, 21 Sep 2023 05:41:59 -0700 (PDT)
Received: from [172.20.41.70] (static-212-193-78-212.thenetworkfactory.nl.
 [212.78.193.212]) by smtp.gmail.com with ESMTPSA id
 r21-20020aa7c155000000b005227e53cec2sm787038edp.50.2023.09.21.05.41.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 05:41:58 -0700 (PDT)
Message-ID: <e0d25860-9fdb-cd56-1d2a-b886af2e3297@linaro.org>
Date: Thu, 21 Sep 2023 14:41:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v3 7/7] qobject atomics osdep: Make a few macros more
 hygienic
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, eblake@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, idryomov@gmail.com, pl@kamp.de,
 sw@weilnetz.de, sstabellini@kernel.org, anthony.perard@citrix.com,
 paul@xen.org, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, thuth@redhat.com, stefanha@redhat.com, fam@euphon.net,
 quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 kraxel@redhat.com, qemu-block@nongnu.org, xen-devel@lists.xenproject.org,
 alex.bennee@linaro.org, peter.maydell@linaro.org
References: <20230921121312.1301864-1-armbru@redhat.com>
 <20230921121312.1301864-8-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230921121312.1301864-8-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 21/9/23 14:13, Markus Armbruster wrote:
> Variables declared in macros can shadow other variables.  Much of the
> time, this is harmless, e.g.:
> 
>      #define _FDT(exp)                                                  \
>          do {                                                           \
>              int ret = (exp);                                           \
>              if (ret < 0) {                                             \
>                  error_report("error creating device tree: %s: %s",   \
>                          #exp, fdt_strerror(ret));                      \
>                  exit(1);                                               \
>              }                                                          \
>          } while (0)
> 
> Harmless shadowing in h_client_architecture_support():
> 
>          target_ulong ret;
> 
>          [...]
> 
>          ret = do_client_architecture_support(cpu, spapr, vec, fdt_bufsize);
>          if (ret == H_SUCCESS) {
>              _FDT((fdt_pack(spapr->fdt_blob)));
>              [...]
>          }
> 
>          return ret;
> 
> However, we can get in trouble when the shadowed variable is used in a
> macro argument:
> 
>      #define QOBJECT(obj) ({                                 \
>          typeof(obj) o = (obj);                              \
>          o ? container_of(&(o)->base, QObject, base) : NULL; \
>       })
> 
> QOBJECT(o) expands into
> 
>      ({
> --->    typeof(o) o = (o);
>          o ? container_of(&(o)->base, QObject, base) : NULL;
>      })
> 
> Unintended variable name capture at --->.  We'd be saved by
> -Winit-self.  But I could certainly construct more elaborate death
> traps that don't trigger it.
> 
> To reduce the risk of trapping ourselves, we use variable names in
> macros that no sane person would use elsewhere.  Here's our actual
> definition of QOBJECT():
> 
>      #define QOBJECT(obj) ({                                         \
>          typeof(obj) _obj = (obj);                                   \
>          _obj ? container_of(&(_obj)->base, QObject, base) : NULL;   \
>      })
> 
> Works well enough until we nest macro calls.  For instance, with
> 
>      #define qobject_ref(obj) ({                     \
>          typeof(obj) _obj = (obj);                   \
>          qobject_ref_impl(QOBJECT(_obj));            \
>          _obj;                                       \
>      })
> 
> the expression qobject_ref(obj) expands into
> 
>      ({
>          typeof(obj) _obj = (obj);
>          qobject_ref_impl(
>              ({
> --->            typeof(_obj) _obj = (_obj);
>                  _obj ? container_of(&(_obj)->base, QObject, base) : NULL;
>              }));
>          _obj;
>      })
> 
> Unintended variable name capture at --->.
> 
> The only reliable way to prevent unintended variable name capture is
> -Wshadow.
> 
> One blocker for enabling it is shadowing hiding in function-like
> macros like
> 
>       qdict_put(dict, "name", qobject_ref(...))
> 
> qdict_put() wraps its last argument in QOBJECT(), and the last
> argument here contains another QOBJECT().
> 
> Use dark preprocessor sorcery to make the macros that give us this
> problem use different variable names on every call.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>   include/qapi/qmp/qobject.h | 10 ++++++++--
>   include/qemu/atomic.h      | 17 ++++++++++++-----
>   include/qemu/compiler.h    |  3 +++
>   include/qemu/osdep.h       | 27 ++++++++++++++++++++-------
>   4 files changed, 43 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


