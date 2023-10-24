Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3341F7D56B1
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:39:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJVB-0000FF-34; Tue, 24 Oct 2023 11:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvJV8-0008Uh-PH; Tue, 24 Oct 2023 11:39:26 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvJV2-000790-9o; Tue, 24 Oct 2023 11:39:25 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2c50cd16f3bso66351061fa.2; 
 Tue, 24 Oct 2023 08:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698161957; x=1698766757; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tlEmeIXZ50wWPACQtQWY4ubCrlx8dw20cymk7ZBn6mM=;
 b=muEO4W6DXs8dma6UcVH4Sw4psckkqRVkjgAmuxfOlCvcs4ur6AxytV4Lo7XSuqYsQ2
 6QfkbnD7IuehcxRrOyCYTJjFMhH80qbWvBYfdVYJ3ZlSXgqCjU3Nifu9Kr6BMAJdklu6
 I412VTSGy6HtF8Xz2w0r91m6vYaEMYABHnyXS46ptlM1mng51Cr40efKz8yWcN4l8JEh
 UIR0YVtz9rMySVYxICwvLvdZ2lxtqovHK4VaWMnkyr7jJtRQGWk4oaXcRaYZsIHKDGkN
 ba4lr4v9qInDOznNpA0rVx8rlDMP4Ipsy6uAKhLKy5U9JZTn4JA1tAvBNkXoS+b1y/Gx
 oyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698161957; x=1698766757;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tlEmeIXZ50wWPACQtQWY4ubCrlx8dw20cymk7ZBn6mM=;
 b=mJD3Ht1XsP+LEqBWs0apJpBUhriCnw+jHVmyrWwSGA90UhAIfCfyL5Hdpl/qrZ2Hu/
 U6ZFXBZEvpCEeWLh0oRk/V4DwzBKWleyValViAXq9Dmt3Zg4bCq3ONRxSqm7tC/2Z3pC
 YsU1Qd94dmXmU4WZVCRQspVIn4/OMsCdSwbDhaBErVUcVwsvbCOtJsP0QOQWIzFRXPk5
 Ccbp2kWkrXFF9/x+LS0uzQIPx0+0z5nt1VxS6MMhzHsad5Gx6Fylk1aNE2nAAlLT64o8
 Zx5nvbFvykSgMvGqSca5ubhCpA6z4PHIyiv6zC4KiiI0Xt3v+I9zhzYBpLxuARkGSnNa
 zMAA==
X-Gm-Message-State: AOJu0Yw3t2oO8sCA0bZ6qxHJQaFIYCNwRIDOyS8exHLFiXVxIae+kTN/
 bFOfS2IIiGJ5u45GEYtvtZ4=
X-Google-Smtp-Source: AGHT+IF0q/RHR9QB8PZoYcnAqa6LCHwv1hACOYhfgQS8+0Un8TgpeFTwgjZUGx/iI4BFscPRP+CgPA==
X-Received: by 2002:a2e:ba9e:0:b0:2c5:1ad0:e306 with SMTP id
 a30-20020a2eba9e000000b002c51ad0e306mr7448511ljf.8.1698161957367; 
 Tue, 24 Oct 2023 08:39:17 -0700 (PDT)
Received: from [192.168.6.66] (54-240-197-238.amazon.com. [54.240.197.238])
 by smtp.gmail.com with ESMTPSA id
 d17-20020a5d6451000000b0032da022855fsm10102024wrw.111.2023.10.24.08.39.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 08:39:16 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <3f22903b-30f0-40f2-8624-b681d9c7e05d@xen.org>
Date: Tue, 24 Oct 2023 16:39:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] hw/xen: add support for Xen primary console in
 emulated mode
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org
References: <20231016151909.22133-1-dwmw2@infradead.org>
 <20231016151909.22133-13-dwmw2@infradead.org>
 <c18439ca-c9ae-4567-bbcf-dffe6f7b72e3@xen.org>
 <3acd078bba2d824f836b20a270c780dc2d031c43.camel@infradead.org>
Organization: Xen Project
In-Reply-To: <3acd078bba2d824f836b20a270c780dc2d031c43.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=xadimgnik@gmail.com; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 24/10/2023 16:37, David Woodhouse wrote:
> On Tue, 2023-10-24 at 15:20 +0100, Paul Durrant wrote:
>> On 16/10/2023 16:19, David Woodhouse wrote:
>>> From: David Woodhouse <dwmw@amazon.co.uk>
>>>
>>> The primary console is special because the toolstack maps a page at a
>>> fixed GFN and also allocates the guest-side event channel. Add support
>>> for that in emulated mode, so that we can have a primary console.
>>>
>>> Add a *very* rudimentary stub of foriegnmem ops for emulated mode, which
>>> supports literally nothing except a single-page mapping of the console
>>> page. This might as well have been a hack in the xen_console driver, but
>>> this way at least the special-casing is kept within the Xen emulation
>>> code, and it gives us a hook for a more complete implementation if/when
>>> we ever do need one.
>>>
>> Why can't you map the console page via the grant table like the xenstore
>> page?
> 
> I suppose we could, but I didn't really want the generic xen-console
> device code having any more of a special case for 'Xen emulation' than
> it does already by having to call xen_primary_console_create().
> 

But doesn't is save you the whole foreignmem thing? You can use the 
grant table for primary and secondary consoles.

   Paul


