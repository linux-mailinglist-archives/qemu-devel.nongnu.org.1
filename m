Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E92C67B498F
	for <lists+qemu-devel@lfdr.de>; Sun,  1 Oct 2023 22:16:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qn2qk-0005M3-6h; Sun, 01 Oct 2023 16:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qn2qe-0005Js-3w
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 16:15:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qn2qc-0002Mr-2Y
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 16:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696191324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=79+OWEPUHbmVkDouFP2XlmQmTvlPaSDMQlfSC4GoL4Y=;
 b=YXmj8d+pB3CnKV+Y+jspI+mzxctWv1aAeG9sbUERlkvrELLBx8qlq9qXpKJjjM27noSjM8
 91JjhKmQMm+dF9xM4NBYOGsOBxjhPM23MCi7Z1iMjWcNLLurwfJOxD479bNdMqBLyTG9oD
 Int2H+OTXy9LX7GcldMiLZzIJ7kj4+M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-ZaBPfYl1Mo2HLSzuQ51W0w-1; Sun, 01 Oct 2023 16:15:23 -0400
X-MC-Unique: ZaBPfYl1Mo2HLSzuQ51W0w-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4055ce1e8c4so10087715e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Oct 2023 13:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696191322; x=1696796122;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=79+OWEPUHbmVkDouFP2XlmQmTvlPaSDMQlfSC4GoL4Y=;
 b=GpFR/vgu33wshLyvChctLXUTgryd3CfhLxWLimOfDkGXCv+GgCJbWqndQgQVYv7pPa
 tmfl9p056OFMT9VPEdVkpmAc/FVlyN+5PrEkLxBZe32/PoCUFFQQeI5hGL0WQj2SgHt3
 QPjyIFndjS7uaxR76hfaGn32iEabsMVwUcsUDYUyJbR7Hpi8RbB5RT0dtpkSIYejzg5X
 6jbQNbUQOIqCI8pmyHOOIr/lnyU0O0MguO6B+xN9jmUHOHc0eRHT61DEZG66cZ57i05S
 f0esQ++R3jPVecMGsnjBfLgO86IUyoUBcqUW3gxa9y3Szeu5f1W9SYKR+BkQxm82nERM
 jSXw==
X-Gm-Message-State: AOJu0YyCXwfJJxd+Xi/brcvwzJsP7tGAtM8m4RhoKYkL25mLSItW97XO
 ze+2c0kGMtZYNSCLHWuGEYgVY8Quj7G+K4WqUzT+oIxRHi6Fay1SFVJLmjSbfqcWEk7sDcrzppw
 64/2P3OSOaPuAePk=
X-Received: by 2002:a7b:cc95:0:b0:406:51a0:17ea with SMTP id
 p21-20020a7bcc95000000b0040651a017eamr8216966wma.10.1696191322317; 
 Sun, 01 Oct 2023 13:15:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpdSCBx+RQL5OJitDhRr13d8w4B0Sk+uOjzpIhS2mNVMKcI1FfeDhN+sJjPI8s9QZ1RNeUAA==
X-Received: by 2002:a7b:cc95:0:b0:406:51a0:17ea with SMTP id
 p21-20020a7bcc95000000b0040651a017eamr8216959wma.10.1696191322001; 
 Sun, 01 Oct 2023 13:15:22 -0700 (PDT)
Received: from redhat.com ([2.52.132.27]) by smtp.gmail.com with ESMTPSA id
 17-20020a05600c029100b004064cd71aa8sm5891563wmk.34.2023.10.01.13.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 13:15:21 -0700 (PDT)
Date: Sun, 1 Oct 2023 16:15:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>,
 marcandre.lureau@gmail.com, philmd@linaro.org, cohuck@redhat.com,
 kraxel@redhat.com
Subject: Re: [PATCH v8 1/4] util/uuid: add a hash function
Message-ID: <20231001161500-mutt-send-email-mst@kernel.org>
References: <20230908154743.809569-1-aesteve@redhat.com>
 <20230908154743.809569-2-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230908154743.809569-2-aesteve@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Sep 08, 2023 at 05:47:40PM +0200, Albert Esteve wrote:
> Add hash function to uuid module using the
> djb2 hash algorithm.
> 
> Add a couple simple unit tests for the hash
> function, checking collisions for similar UUIDs.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  include/qemu/uuid.h    |  2 ++
>  tests/unit/test-uuid.c | 27 +++++++++++++++++++++++++++
>  util/uuid.c            | 15 +++++++++++++++
>  3 files changed, 44 insertions(+)
> 
> diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
> index dc40ee1fc9..e24a1099e4 100644
> --- a/include/qemu/uuid.h
> +++ b/include/qemu/uuid.h
> @@ -96,4 +96,6 @@ int qemu_uuid_parse(const char *str, QemuUUID *uuid);
>  
>  QemuUUID qemu_uuid_bswap(QemuUUID uuid);
>  
> +uint32_t qemu_uuid_hash(const void *uuid);
> +
>  #endif
> diff --git a/tests/unit/test-uuid.c b/tests/unit/test-uuid.c
> index c111de5fc1..aedc125ae9 100644
> --- a/tests/unit/test-uuid.c
> +++ b/tests/unit/test-uuid.c
> @@ -171,6 +171,32 @@ static void test_uuid_unparse_strdup(void)
>      }
>  }
>  
> +static void test_uuid_hash(void)
> +{
> +    QemuUUID uuid;
> +    int i;
> +
> +    for (i = 0; i < 100; i++) {
> +        qemu_uuid_generate(&uuid);
> +        /* Obtain the UUID hash */
> +        uint32_t hash_a = qemu_uuid_hash(&uuid);
> +        int data_idx = g_random_int_range(0, 15);
> +        /* Change a single random byte of the UUID */
> +        if (uuid.data[data_idx] < 0xFF) {
> +            uuid.data[data_idx]++;
> +        } else {
> +            uuid.data[data_idx]--;
> +        }
> +        /* Obtain the UUID hash again */
> +        uint32_t hash_b = qemu_uuid_hash(&uuid);
> +        /*
> +         * Both hashes shall be different (avoid collision)
> +         * for any change in the UUID fields
> +         */
> +        g_assert_cmpint(hash_a, !=, hash_b);
> +    }
> +}
> +
>  int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
> @@ -179,6 +205,7 @@ int main(int argc, char **argv)
>      g_test_add_func("/uuid/parse", test_uuid_parse);
>      g_test_add_func("/uuid/unparse", test_uuid_unparse);
>      g_test_add_func("/uuid/unparse_strdup", test_uuid_unparse_strdup);
> +    g_test_add_func("/uuid/hash", test_uuid_hash);
>  
>      return g_test_run();
>  }
> diff --git a/util/uuid.c b/util/uuid.c
> index b1108dde78..b366961bc6 100644
> --- a/util/uuid.c
> +++ b/util/uuid.c
> @@ -116,3 +116,18 @@ QemuUUID qemu_uuid_bswap(QemuUUID uuid)
>      bswap16s(&uuid.fields.time_high_and_version);
>      return uuid;
>  }
> +
> +/* djb2 hash algorithm */
> +uint32_t qemu_uuid_hash(const void *uuid)
> +{
> +    QemuUUID *qid = (QemuUUID *) uuid;
> +    uint32_t h = 5381;
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(qid->data); i++) {
> +        h = (h << 5) + h + qid->data[i];
> +    }
> +
> +    return h;
> +}
> +

whitespace error:

.git/rebase-apply/patch:85: new blank line at EOF.
+
warning: 1 line adds whitespace errors.




> -- 
> 2.41.0


