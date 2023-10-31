Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F6D7DD7EE
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 22:51:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxwcF-0005WD-Br; Tue, 31 Oct 2023 17:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxwcE-0005Vl-6F
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 17:49:38 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxwcC-0002jp-Dz
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 17:49:37 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-41cbf8e1f77so38702141cf.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 14:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698788975; x=1699393775; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9VvZgVyzDnUJC8F6WF7wdQGwVWcjOcow+np+gcWcEEA=;
 b=OiqqcLFs7WmPJZ2iEOifbTxkAis11TDYJGz5F7DLJv6xLzguP08vmzzmawJcZr6Rj2
 dzSCnUaHrinAOB52RbRp6z2WD8yo/tjOrYBRUzTcMhmxPdPReiMKaW7AdNTXnINWR6FB
 Wig5rh9iNogtoTHAsQ2laFgHVDa2F2UQP7/lVWwOVKu9ah2zNUEXXstKGEEAHUa7WXe8
 kjeW33IJtD3zlwv7WimYpDxJc8GCyj/24eqSXihthBhcZaabrRlOYCJnC7iGXs16V6uG
 Quovc39V3rOHhF+BOUOOQ3cdpMj8EVSM9SQ9o+CUp3xBbm8Jm8Yfvr52soaY9NCrkPNz
 y2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698788975; x=1699393775;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9VvZgVyzDnUJC8F6WF7wdQGwVWcjOcow+np+gcWcEEA=;
 b=wliRwtcwg+511j/qRIFxTs/CkgL+dx9xvKIS6QxYuJoD/ncmqQ1eVnzlvdBaenl111
 Qt/g0AnW0pdA2F1oHxUDmE6hRd8CRjynhdEL/BFghd4bco9CxHe/ELUl4n4jfh6ggRDb
 BgyKL8ueoUuZpCuK/yCtro4hcxUMYEYVKLZoV0lNyIRtvGCRZwX60pk2/xE6E78y4Lfy
 Ww8ZC9XjabAjNiBgpWp8QZ5joAepo0AlHz90SrxwWj1URbQA2CWibLzYXBQ6iqMh0BwJ
 L5HlWfz7e7xKpNiz9DhKF+TEn2e5L9dTcOoZArb0SVX8iiG2QCidDkmld4vRtJNF7S4w
 lyRw==
X-Gm-Message-State: AOJu0YzFrS0ZyZbHh8E4lfqA2A3oeR1iEgAe82FpkgaevgrZzEX6jckJ
 KHNqslcdnmQ+JePCRT3FlEu4NQ==
X-Google-Smtp-Source: AGHT+IFLAMIl8A1NwPY4+lF42ZRWwVwBx87QIDIBRVYVclHFN/O3Ee01zrSG94GKnP0wlrp9J8COoQ==
X-Received: by 2002:a05:622a:50b:b0:417:b545:e962 with SMTP id
 l11-20020a05622a050b00b00417b545e962mr15904808qtx.7.1698788975111; 
 Tue, 31 Oct 2023 14:49:35 -0700 (PDT)
Received: from [192.168.68.107] ([179.193.10.161])
 by smtp.gmail.com with ESMTPSA id
 m11-20020ac8688b000000b004180fb5c6adsm843066qtq.25.2023.10.31.14.49.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 14:49:34 -0700 (PDT)
Message-ID: <81265616-df2d-460c-aea5-0af04b15cd8b@ventanamicro.com>
Date: Tue, 31 Oct 2023 18:49:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] hw/ppc/e500: Pass array of CPUs as array of
 canonical QOM paths
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: Luc Michel <luc.michel@amd.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>, qemu-ppc@nongnu.org,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20231030143957.82988-1-philmd@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231030143957.82988-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 10/30/23 11:39, Philippe Mathieu-Daudé wrote:
> Following the discussion with Peter on my "cpus: Step toward
> removing global 'first_cpu'" series [*], we now pass the array
> of CPUs via property. Since we can not pass array of "link"
> properties, we pass the QOM path of each CPU as a QList(String).
> 
> Tagged as RFC to discuss the idea of using qdev_prop_set_array
> with qlist_append_str(object_get_canonical_path). Personally I
> find it super simple.

I probably misunderstood the concept/problem but "super simple" is not the first
thing that came to my mind in patch 5 hehe

I didn't follow the whole thread, just the [*] message marked and a couple
of replies, but are we planning to deprecate qemu_get_cpu()? Patch 5 mentions
"Devices should avoid calling qemu_get_cpu() because this call doesn't work
as expected with heterogeneous machines". I'll take your word for it. But
e500 isn't an heterogeneous machine - we're creating ppc cpus only. So I'm
a bit confused here. Are you using e500 just as a simple PoC?

Regardless of the reason to use e500 in this RFC, I believe we would benefit
from having common helpers/magic sauce macros to add all this apparently
boilerplate code to replace qemu_get_cpu().

I mean, we're changing this:

-    cpu = qemu_get_cpu(env_idx);
-    if (cpu == NULL) {
-        /* Unknown CPU */
-        return;
-    }
-

For a lot of QOM stuff like this:


+        cpu_qompath = object_get_canonical_path(OBJECT(cs));
+        qlist_append_str(spin_cpu_list, cpu_qompath);
+    qdev_prop_set_array(dev, "cpus-qom-path", spin_cpu_list);


+    if (s->cpu_count == 0) {
+        error_setg(errp, "'cpus-qom-path' property array must be set");
+        return;
+    } else if (s->cpu_count > MAX_CPUS) {
+        error_setg(errp, "at most %d CPUs are supported", MAX_CPUS);
+        return;
+    }
+
+    s->cpu = g_new(CPUState *, s->cpu_count);
+    for (unsigned i = 0; i < s->cpu_count; i++) {
+        bool ambiguous;
+        Object *obj;
+
+        obj = object_resolve_path(s->cpu_canonical_path[i], &ambiguous);
+        assert(!ambiguous);
+        s->cpu[i] = CPU(obj);
+    }
+
+static Property ppce500_spin_properties[] = {
+    DEFINE_PROP_ARRAY("cpus-qom-path", SpinState, cpu_count,
+                      cpu_canonical_path, qdev_prop_string, char *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+

So anything that makes the QOM stuff more palatable to deal with would be
really appreciated. Thanks,


Daniel


> 
> Regards,
> 
> Phil.
> 
> [*] https://lore.kernel.org/qemu-devel/CAFEAcA9FT+QMyQSLCeLjd7tEfaoS9JazmkYWQE++s1AmF7Nfvw@mail.gmail.com/
> 
> Kevin Wolf (1):
>    qdev: Add qdev_prop_set_array()
> 
> Philippe Mathieu-Daudé (4):
>    hw/ppc/e500: Declare CPU QOM types using DEFINE_TYPES() macro
>    hw/ppc/e500: QOM-attach CPUs to the machine container
>    hw/ppc/e500: Inline sysbus_create_simple(E500_SPIN)
>    hw/ppc/e500: Pass array of CPUs as array of canonical QOM paths
> 
>   include/hw/qdev-properties.h |  3 ++
>   hw/core/qdev-properties.c    | 21 +++++++++++
>   hw/ppc/e500.c                | 11 +++++-
>   hw/ppc/ppce500_spin.c        | 69 ++++++++++++++++++++++++++----------
>   4 files changed, 84 insertions(+), 20 deletions(-)
> 

