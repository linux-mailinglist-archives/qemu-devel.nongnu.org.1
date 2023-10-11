Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4397C5827
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 17:36:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqbFZ-0004lO-8R; Wed, 11 Oct 2023 11:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqbF5-0004dy-DF
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:35:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqbF0-00013u-3s
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697038516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8R6Sv9z8EkL6vXSzdDypuQTHXpmVHkNktIfQRgcdrWM=;
 b=aagY2GV4mPzXC5w2T2p4HGNC4MBx4yg0Tt7lkkbczSPA7/UuhqwyRgy6SiQghndIbV8dl7
 Ckd+uHjsC7FBh3CXF5+oNEOfvxoGqP469wnO4UlfWrPLLb6Kznsj+iYXdd2QGGwfacDon6
 yXQuN+1HsqXShbCcS3VpgOHrCcMCZJU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-CTUFB6_0Nc-hlJooZUVlXQ-1; Wed, 11 Oct 2023 11:35:14 -0400
X-MC-Unique: CTUFB6_0Nc-hlJooZUVlXQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-66acad63d74so85601946d6.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 08:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697038513; x=1697643313;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8R6Sv9z8EkL6vXSzdDypuQTHXpmVHkNktIfQRgcdrWM=;
 b=ot5d+AFl3tLbdFNXWNN6fFMv0ebof1Q61fi+RRSUcLmmrdHYiGLnbbRZicaNSgI2CW
 J+Ej/PQjtgEEvTt+8sLNUOuGuCz12QLJpA+A0YpC1UeljspAM2wHK1ar0w9likz5EGON
 zyzLVvNe2zomXLvhaShk284J/0OS/3Ta1UplgXIuVEpxj03PCQhJFO+gzh2IB4//h0YA
 xuRb5k3QAvyVCsPNN0anSe+VzAp1DzmnJvgCFS0JRuSUjuczJiNrPAR1qPEr+0JK5v2b
 irlbOgZR1vEC+ScNpBMOCwA28YSEmmzK4M/+Cszj5w8gdmlJoYG7yY0GhXbqxdtXm/Xb
 /63g==
X-Gm-Message-State: AOJu0YxJr7sUxIEAfohCCg9CnuQ7/cGyd6b3pHH1EaKMoIDqEVRlpOlq
 0JQIwyajUbWvaCccqboLQI7+5eP0wX1m74KwnFNNU9qjYya+pP3m7CBKJ/VETL5epP1lnytwugx
 q84Ih1ffJ+qnD4jA=
X-Received: by 2002:a0c:e34a:0:b0:66d:9d2:8312 with SMTP id
 a10-20020a0ce34a000000b0066d09d28312mr1573274qvm.49.1697038512927; 
 Wed, 11 Oct 2023 08:35:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLLerqWC9eo+Du8A7VtutKFj5injpmaZFW4xrLegKb2ey09ffeiowWrYzJ88Z8cyRqp9V8XQ==
X-Received: by 2002:a0c:e34a:0:b0:66d:9d2:8312 with SMTP id
 a10-20020a0ce34a000000b0066d09d28312mr1573259qvm.49.1697038512686; 
 Wed, 11 Oct 2023 08:35:12 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-176.web.vodafone.de.
 [109.43.176.176]) by smtp.gmail.com with ESMTPSA id
 z6-20020a0ce986000000b0065b29403540sm1658938qvn.127.2023.10.11.08.35.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 08:35:12 -0700 (PDT)
Message-ID: <cacc4a01-88e9-4631-a6d6-fbee2b483fd6@redhat.com>
Date: Wed, 11 Oct 2023 17:35:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/10] hw/fsi: Added qtest
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org, clg@kaod.org, 
 peter.maydell@linaro.org, andrew@aj.id.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20231011151339.2782132-1-ninad@linux.ibm.com>
 <20231011151339.2782132-9-ninad@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231011151339.2782132-9-ninad@linux.ibm.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/10/2023 17.13, Ninad Palsule wrote:
> Added basic qtests for FSI model.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
> v3:
>   - Added new qtest as per Cedric's comment.
> V4:
>   - Remove MAINTAINER and documentation changes from this commit
> ---
>   tests/qtest/fsi-test.c  | 210 ++++++++++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build |   2 +
>   2 files changed, 212 insertions(+)
>   create mode 100644 tests/qtest/fsi-test.c
> 
> diff --git a/tests/qtest/fsi-test.c b/tests/qtest/fsi-test.c
> new file mode 100644
> index 0000000000..30bb7475c7
> --- /dev/null
> +++ b/tests/qtest/fsi-test.c
> @@ -0,0 +1,210 @@
...
> +int main(int argc, char **argv)
> +{
> +    int ret = -1;
> +    QTestState *s;
> +
> +    g_test_init(&argc, &argv, NULL);
> +
> +    s = qtest_init("-machine ast2600-evb ");
> +    if (s == NULL) {
> +        return -ENOMEM;

returning -ENOMEM here does not make too much sense ... and actually 
qtest_init() cannot return NULL. So please drop this if-statement.

> +    }
> +
> +    /* Tests for OPB/FSI0 */
> +    qtest_add_data_func("/fsi-test/test_fsi0_master_regs", s,
> +                        test_fsi0_master_regs);
> +
> +    qtest_add_data_func("/fsi-test/test_fsi0_getcfam_addr0", s,
> +                        test_fsi0_getcfam_addr0);
> +
> +    /* Tests for OPB/FSI1 */
> +    qtest_add_data_func("/fsi-test/test_fsi1_master_regs", s,
> +                        test_fsi1_master_regs);
> +
> +    qtest_add_data_func("/fsi-test/test_fsi1_getcfam_addr0", s,
> +                        test_fsi1_getcfam_addr0);
> +
> +    ret = g_test_run();
> +    qtest_quit(s);
> +
> +    return ret;
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index b071d400b3..5976081b44 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -207,6 +207,7 @@ qtests_arm = \
>     (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
>     (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []) + \
>     (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
> +  (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['fsi-test'] : []) + \
>     ['arm-cpu-features',
>      'boot-serial-test']
>   
> @@ -318,6 +319,7 @@ qtests = {
>     'tpm-tis-device-test': [io, tpmemu_files, 'tpm-tis-util.c'],
>     'vmgenid-test': files('boot-sector.c', 'acpi-utils.c'),
>     'netdev-socket': files('netdev-socket.c', '../unit/socket-helpers.c'),
> +  'fsi-test': files('fsi-test.c'),

I think this hunk here is not required - you only need to specify additional 
dependencies here, not the main file.

  Thomas


