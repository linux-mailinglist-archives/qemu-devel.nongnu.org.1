Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEFC725B03
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 11:46:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6pkD-0001q8-Aw; Wed, 07 Jun 2023 05:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6pk8-0001px-76
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 05:46:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6pk6-0006w8-JR
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 05:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686131173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qn6QXrGo/7TLsxB6Vfxngeo4ZFaZuD6fqSOn5lLvrkg=;
 b=QhUsdMRdMy2FOnV9MvPeT/oGInHe/8DO3kOE/a2UQ++N/nNs9zVXuaRIfRXDIj2P1PR18a
 nsX1h5FUlJbajHPekYed2rVvPXugt0IfCbjiZrX0a0vTXXx9hOol+oLGF5qmkBlbcIPGhN
 A+Y85lXvhDq+bm57TQCklkG2/T6fF5E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-OpypeFy9NDCG8Yq90qmfRA-1; Wed, 07 Jun 2023 05:46:11 -0400
X-MC-Unique: OpypeFy9NDCG8Yq90qmfRA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30e4d85e1ffso2438947f8f.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 02:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686131170; x=1688723170;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qn6QXrGo/7TLsxB6Vfxngeo4ZFaZuD6fqSOn5lLvrkg=;
 b=irDjVMvK6Lisy57Pc/Xl06svyQnFSHxDpSM3oNnQeGI+jBZXnKvhfkGXnmsBo5tlxJ
 3mfyqOe8kmdiar4HANk4X26+wjjtcDGGIgKfwn2hdHuhRWet558DxfBIw7WwyjBS/NYb
 npIwiMN2UvtvuvpjW74na+LBPUQLgo1FbRryxWHJf5pLJ6wZXiF2ZEarO9N5Vn5JcOHu
 Il868hsXs5upYTT8zHC1PtlLSwKxS1wQPW8UJbdpmBNDd7N/vWlg6OkjBemPXyGLnu8b
 XaUtxd6ratfGJ2px2pnmVgLKOlsSg0pc/zt9epK6m4H4au7kXVuC1cLaxIV79tdzR5Ym
 O2vw==
X-Gm-Message-State: AC+VfDyIXrAJ9ULikTLtZ3EeFHVNW+x6KxzV7Qvw119NSPV+vOM8CZib
 xVin5U3VNfPV8IgSQ4NsFiri4hL3nVte6AkfcU1ebceOWX/IEZIzQMhTVt1EkO43moF6V7W9mLZ
 bkAqglq9Fqe1w8I+Zq86k1DQ=
X-Received: by 2002:a5d:6943:0:b0:30a:e469:3bb5 with SMTP id
 r3-20020a5d6943000000b0030ae4693bb5mr4187478wrw.30.1686131170830; 
 Wed, 07 Jun 2023 02:46:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5vjiK1vHQwP+MFFQR7xzpRE7AAulfYAFzxXd+Y9h0WXOMplH8sXJfb6pF10G6Wjk3sy0wpng==
X-Received: by 2002:a5d:6943:0:b0:30a:e469:3bb5 with SMTP id
 r3-20020a5d6943000000b0030ae4693bb5mr4187467wrw.30.1686131170505; 
 Wed, 07 Jun 2023 02:46:10 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-42-114-92.web.vodafone.de.
 [109.42.114.92]) by smtp.gmail.com with ESMTPSA id
 e3-20020adfef03000000b0030e52d4c1bcsm3271932wro.71.2023.06.07.02.46.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 02:46:10 -0700 (PDT)
Message-ID: <c21f16ae-f653-4150-1372-b33f99342bf2@redhat.com>
Date: Wed, 7 Jun 2023 11:46:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Building of docs does not work anymore
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
References: <b869ab5c-7b2f-93fc-678f-53ee39118f97@redhat.com>
In-Reply-To: <b869ab5c-7b2f-93fc-678f-53ee39118f97@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.094, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 07/06/2023 11.42, Thomas Huth wrote:
> 
>   Hi Paolo, hi John,
> 
> since the recent reworks with the Python venv, building of the docs does not 
> work for me on my RHEL 8 installation anymore.
> 
> If I just run "configure" without any additional arguments, I get:
> 
> ------------------------- 8< -----------------------------
> $ ./configure
> Using './build' as the directory for build output
> python determined to be '/usr/bin/python3.8'
> python version: Python 3.8.13
> mkvenv: Creating non-isolated virtual environment at 'pyvenv'
> mkvenv: checking for meson>=0.63.0
> mkvenv: installing meson>=0.63.0
> mkvenv: checking for sphinx>=1.6.0, sphinx-rtd-theme>=0.5.0
> 
> *** Ouch! ***
> 
> Could not provide build dependency 'sphinx>=1.6.0':
>   • Python package 'sphinx' was not found nor installed.
>   • mkvenv was configured to operate offline and did not check PyPI.
>   • 'sphinx-build' was detected on your system at '/usr/bin/sphinx-build', 
> but the Python package 'sphinx' was not found by this Python interpreter 
> ('/usr/bin/python3.8'). Typically this means that 'sphinx-build' has been 
> installed against a different Python interpreter on your system.
> 
> Sphinx not found/usable, disabling docs.
> ------------------------- 8< -----------------------------
> 
> If I enable downloads and enforce --enable-docs , I get:
> 
> ------------------------- 8< -----------------------------
> ./configure --enable-docs --enable-download
> Using './build' as the directory for build output
> python determined to be '/usr/bin/python3.8'
> python version: Python 3.8.13
> mkvenv: Creating non-isolated virtual environment at 'pyvenv'
> mkvenv: checking for meson>=0.63.0
> mkvenv: installing meson>=0.63.0
> mkvenv: checking for sphinx>=1.6.0, sphinx-rtd-theme>=0.5.0
> mkvenv: installing sphinx>=1.6.0, sphinx-rtd-theme>=0.5.0
> ERROR: sphinx-rtd-theme 1.2.1 has requirement docutils<0.19, but you'll have 
> docutils 0.20.1 which is incompatible.
> ERROR: sphinx-rtd-theme 1.2.1 has requirement sphinx<7,>=1.6, but you'll 
> have sphinx 7.0.1 which is incompatible.
> ------------------------- 8< -----------------------------

Actually, it seems like it builds the docs in the latter case ... but the 
two error messages still look quite menacing (printed with red letters).

  Thomas


