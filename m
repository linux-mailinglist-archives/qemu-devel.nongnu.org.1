Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3CA7EC78E
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 16:43:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3I1L-0003Fe-Q8; Wed, 15 Nov 2023 10:41:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3I1I-0003F6-F1
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 10:41:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3I1G-0000hL-C7
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 10:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700062893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ajeHORh07Xa9RqvF2UDxZ/osz/x91zpB/aa22hSjNq8=;
 b=Ue8hfG8eIqGJgnf95qytusCt2vSXlhDFG0X7Ds8iDRJ+2xFdhFCqzUNqESagAhv3LX+Mbk
 wZZ/sVujIrTyCxs2VAGlx2hPz1/kgqwbx66h3Cz82S8+flPasMt+2MsYha4b5LcGRcQVKP
 nL0eKUeyXctQPlOzA8MNW4JV9NGwfJk=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-6EcHtqZeOX6U8PrGv9f4-Q-1; Wed, 15 Nov 2023 10:41:31 -0500
X-MC-Unique: 6EcHtqZeOX6U8PrGv9f4-Q-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6ce270bc429so7140493a34.2
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 07:41:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700062890; x=1700667690;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ajeHORh07Xa9RqvF2UDxZ/osz/x91zpB/aa22hSjNq8=;
 b=LluOSnIgHe4hcEY6goFe1y+Wf3LeozdhWcIB9Ou+T0lKabwUuZ2kopcf/UyOC0wKP8
 ig34KeDylOx5fe9hPlXrga8ElTtX5xz9qclqLby/O3l2WexODbPvuSJpvD0Z6Txn1If2
 zuuACuKnSi4D3FIuOFneIrvL/2g6a+0QOfuDVXp2L8Sebu1zp58LdMg306rS4MSXoFob
 mWcwCtwx9hWs7XkzCTF0K5cHHvCpokqsvITxbrydDgumSDh3y+tIRpoQqL1fKWuGdi+x
 yE4OVdWt/Q2eDmhmcNrmvU1oauilp/GojdcfdLTa3cClhTbEl/lD+ilx1I7mFV6eLCfO
 Uh0Q==
X-Gm-Message-State: AOJu0Yw5gNnKCT/dyNY6qYrb3tknlnRRbwRn/a7m78isNoir1YWGWXwn
 TeoW0Biv0BjFqZwbVHtZY4pPYS6y7lE197akFqqXdGpn4sdV0LHQVv9OjqSsxWpQLtnenpdEEoG
 JItZhC35Dsig+1PM=
X-Received: by 2002:a9d:624a:0:b0:6bd:1059:8212 with SMTP id
 i10-20020a9d624a000000b006bd10598212mr5408117otk.26.1700062890706; 
 Wed, 15 Nov 2023 07:41:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7nrLsylzJrd2OBPdTUJ/798sQ03eRqVrfnqZvosEs817n++qUQ9WOUpenMkI166nt8sTSyQ==
X-Received: by 2002:a9d:624a:0:b0:6bd:1059:8212 with SMTP id
 i10-20020a9d624a000000b006bd10598212mr5408094otk.26.1700062890385; 
 Wed, 15 Nov 2023 07:41:30 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-176-122.web.vodafone.de.
 [109.43.176.122]) by smtp.gmail.com with ESMTPSA id
 t18-20020a056214119200b00670e0f71ff7sm622892qvv.90.2023.11.15.07.41.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 07:41:29 -0800 (PST)
Message-ID: <e9b3d61c-e604-4cbf-bd43-21816339a547@redhat.com>
Date: Wed, 15 Nov 2023 16:41:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2?] tests/avocado: Make fetch_asset()
 inconditionally require a crypto hash
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20231115153247.89486-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231115153247.89486-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 15/11/2023 16.32, Philippe Mathieu-Daudé wrote:
> In a perfect world we'd have reproducible tests,
> but then we'd be sure we run the same binaries.
> If a binary artifact isn't hashed, we have no idea
> what we are running. Therefore enforce hashing for
> all our artifacts.
> 
> With this change, unhashed artifacts produce:
> 
>    $ avocado run tests/avocado/multiprocess.py
>     (1/2) tests/avocado/multiprocess.py:Multiprocess.test_multiprocess_x86_64:
>     ERROR: QemuBaseTest.fetch_asset() missing 1 required positional argument: 'asset_hash' (0.19 s)
> 
> Inspired-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20231115145852.494052-1-thuth@redhat.com>
>    "tests/avocado/multiprocess: Add asset hashes to silence warnings"
> ---
>   tests/avocado/avocado_qemu/__init__.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/avocado/avocado_qemu/__init__.py b/tests/avocado/avocado_qemu/__init__.py
> index d71e989db6..304c428168 100644
> --- a/tests/avocado/avocado_qemu/__init__.py
> +++ b/tests/avocado/avocado_qemu/__init__.py
> @@ -254,7 +254,7 @@ def setUp(self, bin_prefix):
>               self.cancel("No QEMU binary defined or found in the build tree")
>   
>       def fetch_asset(self, name,
> -                    asset_hash=None, algorithm=None,
> +                    asset_hash, algorithm=None,
>                       locations=None, expire=None,
>                       find_only=False, cancel_on_missing=True):
>           return super().fetch_asset(name,

I think this already makes sense to avoid that those annoying warnings could 
get in again in the future!

Reviewed-by: Thomas Huth <thuth@redhat.com>


