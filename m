Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9A17852BB
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 10:34:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYjJR-00034x-99; Wed, 23 Aug 2023 04:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYjJO-00034p-8P
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:33:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYjJM-0003X8-OU
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692779635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N7iF+JguI63acLUEEwtPEJiiHc5TcriATfrBACKnceU=;
 b=P6mwowCV68p/IHbNmWj/We129y2MbvtiWNWEdVQPbWEscVhKF0eNIg6rXg+I5LbzoQFtyg
 GxWke+R7aFhhXWP9JE1RmPtpWtbycCfxgT4hKhjpnotCTUoFlYaiAxKDiSvV1ywnPg08jl
 SOhjUD0lCoCITJxrg4rNapvfCQ9zkIY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-Or-pRS3UPMim7jN6Ge7Q5w-1; Wed, 23 Aug 2023 04:33:54 -0400
X-MC-Unique: Or-pRS3UPMim7jN6Ge7Q5w-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31aef4011cfso2405405f8f.2
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 01:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692779633; x=1693384433;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N7iF+JguI63acLUEEwtPEJiiHc5TcriATfrBACKnceU=;
 b=CwyueKJOiiv9iRYSne1ExyyjusBqV2ijxbZiI+XcXeDBBUrBEvfYuVxIzD+RqhbuUr
 AtWBb185wSjvCsgsIxo3Nqy3QWF4SGaJPWWHlaUh2lgoCpewyRCJjtrDUgTUXQ51TIUo
 dbWIo3ctlD5jT4DAes4Hiib5l0vgrgwBf/+YvrpVhNVtzOFjZQo7smQbGmQQC5gBct/M
 BpFu6QVtXyKB1m8xW5sU56wXCie/0vByvTTfFUg0m7ZcuQxz6XnGvNwP+HG5h2yy2Jev
 qfEo6vXzcY1xRWVwL7bUzL2myF0N7oF+F/iRXD8Iwuz+DAS7RW8Jfyw93eFBPmTzbM90
 WvMA==
X-Gm-Message-State: AOJu0Yy+YUcQImNUZEYwWoyV5ZuGTDEem7/imZmwk2wEJekBvOnpEeXQ
 spXtWgxB3Dx30OKnxX+mnzVwTt/3+kvRru1OQEm6ykbqDIXuPrUc1PbL1Zh6N3vao3f7Yyu8zTU
 s0kFHMVvKVWTr7FU=
X-Received: by 2002:adf:e4ca:0:b0:31a:d9bc:47aa with SMTP id
 v10-20020adfe4ca000000b0031ad9bc47aamr7157144wrm.67.1692779633045; 
 Wed, 23 Aug 2023 01:33:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGVhm6B5F7MLr6wEWcn3EUlIWHIRFnYdaNypZei+nd4EHXeF3UWqeLWucdGI4vwjENHe8BQg==
X-Received: by 2002:adf:e4ca:0:b0:31a:d9bc:47aa with SMTP id
 v10-20020adfe4ca000000b0031ad9bc47aamr7157131wrm.67.1692779632781; 
 Wed, 23 Aug 2023 01:33:52 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-178.web.vodafone.de.
 [109.43.177.178]) by smtp.gmail.com with ESMTPSA id
 n4-20020a5d4204000000b0031c5dda3aedsm5872775wrq.95.2023.08.23.01.33.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 01:33:52 -0700 (PDT)
Message-ID: <1415ac82-0769-a25d-1dbd-c8382b9c52b2@redhat.com>
Date: Wed, 23 Aug 2023 10:33:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] meson: Use subprocess.check_output()
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20230812091111.13411-1-akihiko.odaki@daynix.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230812091111.13411-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.767, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/08/2023 11.11, Akihiko Odaki wrote:
> subprocess.check_output() is a more concise way to execute a subprocess
> here.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Based-on: <20230812061540.5398-1-akihiko.odaki@daynix.com>
> ("[PATCH] meson: Fix MESONINTROSPECT parsing")

Since that other patch has never been merged, this patch here does not apply 
to master ... could you maybe respin it for the plain master branch?

  Thomas



