Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3777EB2F9
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 16:01:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2utq-0000YM-Pb; Tue, 14 Nov 2023 10:00:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2utl-0000WH-Ar
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 10:00:20 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2utj-0003fv-92
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 10:00:16 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5441305cbd1so8788930a12.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 07:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699974013; x=1700578813; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hvwMnVTQaJD67434mMenkNkErgsf9DqTmkoP4qGMiTA=;
 b=ao4sP0KLLAUizKlThD8vEofY9SW978HG6r7hV0QSNzTnM5obYQNUf+dEfPIDrb4LBt
 wHYZHWaPZ5xZHnI2xL0ghYAf/lj+zbqASEvUjtHiYWDEBbVhHL20x1QYZufOtwXT9rSI
 uQcS86BpDeulm/B1bYzR15ZNST+dNM4BpuA3dvYvMYiaaaW1d9Zxlm4peim8nDm5/ce0
 71MVCm+5Aco0sNNkmjsZ5XDFO/KNN567px559qDsjEnwfvhDSz91Htu4VTma7Zi4oG6n
 dy/xjuTAKa5Ooys23/fXrt3MWdOf7rXpFpLWm+klEKyUn0XKB8ywVIHF/u4+lizJo2Sd
 j+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699974013; x=1700578813;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hvwMnVTQaJD67434mMenkNkErgsf9DqTmkoP4qGMiTA=;
 b=m+Ta/mITKISrfZ5FnOyNyA84n9pyIlzMDEzply6Xh3dfev3BSDaEckK0wD5Bnp4bbL
 i1bD877HUqLi5YjqG+fgVr4dHChyCtA45euKATH82BAZZiV5T2dY/LC6jn5ezS+DMtmy
 7Xfn3dLFV9pDTyrRnzDzB4Cts26k0Sb0JEnKFa8kC/pajfFScmQh6Er0DqqTN5fr5JrR
 XG0Ibbc+91g/OfYLTqIeayvA/nFz5NwMcQxw07fW0B94TXKP/i0GrIPKNIw7d9Okxmja
 R6iAId+o8k8GcHsWFwk5UYbAm3m6zmuGf290+c1J+15OQdRvJy+D4pQX1HvW7W7wiGei
 Nb6w==
X-Gm-Message-State: AOJu0YzpV2hkE9/p3NVA0PghWjNysmk9r8LvgdMi3uxdZIS+bS74FhWg
 +QNeiMZZxfmyINb7TD2WpqqOgpUSBU82SQjtxTo=
X-Google-Smtp-Source: AGHT+IHf7MXlWtvkPtL4rKaxAjHGg7eiFZd1cU9GCPUEE1OMwcKoAJdSYUPudWARuJ4FPvDMOa6uyA==
X-Received: by 2002:a17:906:7e06:b0:9d3:5d4a:8b6a with SMTP id
 e6-20020a1709067e0600b009d35d4a8b6amr7254726ejr.42.1699974013091; 
 Tue, 14 Nov 2023 07:00:13 -0800 (PST)
Received: from [192.168.69.100] (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 ay18-20020a170906d29200b009ce03057c48sm5685319ejb.214.2023.11.14.07.00.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 07:00:12 -0800 (PST)
Message-ID: <407f32ee-e489-4c05-9c3d-fa6c29bb1d99@linaro.org>
Date: Tue, 14 Nov 2023 16:00:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 v2 01/19] tests/avocado: Add 'guest:xen' tag to
 tests running Xen guest
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, David Woodhouse
 <dwmw@amazon.co.uk>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 Anthony Perard <anthony.perard@citrix.com>, kvm@vger.kernel.org,
 Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20231114143816.71079-1-philmd@linaro.org>
 <20231114143816.71079-2-philmd@linaro.org>
 <94D9484A-917D-4970-98DE-35B84BEDA1DC@infradead.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <94D9484A-917D-4970-98DE-35B84BEDA1DC@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

On 14/11/23 15:50, David Woodhouse wrote:
> On 14 November 2023 09:37:57 GMT-05:00, "Philippe Mathieu-Daudé" <philmd@linaro.org> wrote:
>> Add a tag to run all Xen-specific tests using:
>>
>>   $ make check-avocado AVOCADO_TAGS='guest:xen'
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> tests/avocado/boot_xen.py      | 3 +++
>> tests/avocado/kvm_xen_guest.py | 1 +
>> 2 files changed, 4 insertions(+)
> 
> Those two are very different. One runs on Xen, the other on KVM. Do we want to use the same tag for both?

My understanding is,
- boot_xen.py runs Xen on TCG
- kvm_xen_guest.py runs Xen on KVM
so both runs Xen guests.

Alex, is that incorrect?

