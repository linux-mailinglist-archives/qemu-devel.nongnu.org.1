Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 836A4B11770
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Jul 2025 06:33:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufA7T-0004PB-Sb; Fri, 25 Jul 2025 00:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ufA6Z-0004HW-IO
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 00:32:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ufA6X-0008Uj-D8
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 00:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753417940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fPcqmt9pOXNUutSj4zxW9FlQyVxeJvrE58L66rg+b3I=;
 b=d/VZoiN9rH6YZVF8NdnW+6VnJUIEFLKgrAlzSAr7oVJcHOiapN7s/ODtjEQ0s/RQ4BNdOl
 9eO18LTLNqDY2cKL8VLK2eHYZFFIwPmCbaOq1AlSSMYRLvgE6+NHC+UkWjxP2FynoN5ZUA
 8SCVsOMeAGeKAXvZcKsCzW31LzwTSx4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-p4566RzoPS-IW7cKyzd6cw-1; Fri, 25 Jul 2025 00:32:18 -0400
X-MC-Unique: p4566RzoPS-IW7cKyzd6cw-1
X-Mimecast-MFC-AGG-ID: p4566RzoPS-IW7cKyzd6cw_1753417937
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451d30992bcso11841725e9.2
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 21:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753417937; x=1754022737;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fPcqmt9pOXNUutSj4zxW9FlQyVxeJvrE58L66rg+b3I=;
 b=em65sdAHhYePCT86bnvRN7K7GNB4u7ee3xP2JaCwebe6qovXjJN2p+Xqzei2zlk0BY
 gARpr/71uOgqTr80bHPV+AovBz/i0NuMXiVDk+wzGxRRszExSI9YUvHUxUmF7mEru91c
 2TJMgPy7pcrj+fNodXuBma8nhGdXiwHQkgIW+AaVcypDPKDSgiMlSOeDy7vooa7MKY6+
 6qfjCqU58ZA+idNSniRoyQQ/sx7mVFyVABV16L+wt6PbNs7GjkvQKuKgImemz1QcLJFX
 YZaND7HtMavnJ0KpItbvMMyTKnM1KJ7kX4Tk4lZL8uev+jWX7YNoTB8vHl9B3YueHhHg
 d+dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZNfekYGYA7UlIuk77ppVLRf3mxE06zrAXFO6shdjigOIh04a2qxI+n9MRExQRxOiC1wOn2pV79wZ8@nongnu.org
X-Gm-Message-State: AOJu0YzFi5C/5il92NJykgEXrmeyha7JDnWSLgLhZM4LZYAq7wt1AIo9
 mc7Gipv16+wqGINZpZWADm5e9zK8RCMDbnnFyyh3DRBc9glQRklw8XNLnO3f9b3/POql44fjOQ3
 C8AYzWbkzyvpDA1qGAovpFu/kOiDhLpXxwiMTrTa2jCkSShfNYE+f0SAR
X-Gm-Gg: ASbGncub3QOr18URDWZjldYbzE5wDe5njTXY6ig9TiwdroLqgmoqRjqH1WHSgCJ3Riv
 S6taAzn7+p1n1pEQMuW6SrCZjbUv+meE3Ypis4lWb537Rt0hfYkLDLcQCYYKrQm6dcprhjQ/jP7
 BnGlAzoHOE7pfOszozDMU2YUCLTY3hR64Jz7e89RlnL/GrdtCIXb2bhE7AhgByb0dqKLKKON4sH
 afWU8zNjMSbvJROFQLOzQRrnUoLgFwapFkqAZWqQeldkuB1tjFopbXZjjwi6xLCc0tUFXWM5EPg
 b2EuXHUl1dMBLD/nfCKOe4X4BcSZYqNV6isd85/BXpZ5yzu0z1eDwgvbY+Ek852wc8aNzu+3y+K
 Ednk=
X-Received: by 2002:a05:600c:3ace:b0:456:25aa:e9b0 with SMTP id
 5b1f17b1804b1-4587654b626mr2764955e9.16.1753417936763; 
 Thu, 24 Jul 2025 21:32:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrJ4zazujOnsJSYCSUyVz7oDaeWPFuxZKtIt9XLBY7c3jMPfaCg6PZxVLqQj42TiHPB2KoVA==
X-Received: by 2002:a05:600c:3ace:b0:456:25aa:e9b0 with SMTP id
 5b1f17b1804b1-4587654b626mr2764785e9.16.1753417936389; 
 Thu, 24 Jul 2025 21:32:16 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-115-089.pools.arcor-ip.net.
 [47.64.115.89]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45870554a02sm40315375e9.21.2025.07.24.21.32.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 21:32:15 -0700 (PDT)
Message-ID: <5510b8fb-82af-474b-a735-6f2334608f46@redhat.com>
Date: Fri, 25 Jul 2025 06:32:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] tests/functional: add --keep-scratch CLI arg
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250718-functional_tests_args-v2-0-cde6e08bf98e@linaro.org>
 <20250718-functional_tests_args-v2-1-cde6e08bf98e@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250718-functional_tests_args-v2-1-cde6e08bf98e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 18/07/2025 13.04, Manos Pitsidianakis wrote:
> Add CLI arg to keep scratch files after test execution, equivalent to
> setting QEMU_TEST_KEEP_SCRATCH env var.
> 
> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   tests/functional/qemu_test/testcase.py | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index 3ecaaeffd4df2945fb4c44b4ddef6911527099b9..9b00c63e6ca7a2a669fd456f1d1b51501ce4a726 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -43,6 +43,13 @@ def parse_args(test_name: str) -> argparse.Namespace:
>           help="Also print test and console logs on stdout. This will make the"
>           " TAP output invalid and is meant for debugging only.",
>       )
> +    parser.add_argument(
> +        "--keep-scratch",
> +        action="store_true",
> +        help="Do not purge any scratch files created during the tests. "
> +        "This is equivalent to setting QEMU_TEST_KEEP_SCRATCH=1 in the "
> +        "environment.",
> +    )
>       return parser.parse_args()
>   
>   
> @@ -214,6 +221,9 @@ def setUp(self):
>           path = os.path.basename(sys.argv[0])[:-3]
>           args = parse_args(path)
>           self.stdout_handler = None
> +        self.keep_scratch = (
> +            "QEMU_TEST_KEEP_SCRATCH" in os.environ or args.keep_scratch
> +        )
>           if args.debug:
>               self.stdout_handler = logging.StreamHandler(sys.stdout)
>               self.stdout_handler.setLevel(logging.DEBUG)
> @@ -255,8 +265,10 @@ def setUp(self):
>               self.skipTest('One or more assets is not available')
>   
>       def tearDown(self):
> -        if "QEMU_TEST_KEEP_SCRATCH" not in os.environ:
> +        if not self.keep_scratch:
>               shutil.rmtree(self.workdir)
> +        else:
> +            self.log.info(f"Kept scratch files in {self.workdir}")
>           if self.socketdir is not None:
>               shutil.rmtree(self.socketdir.name)
>               self.socketdir = None
> 

Acked-by: Thomas Huth <thuth@redhat.com>


