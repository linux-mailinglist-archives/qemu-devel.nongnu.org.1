Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC267CC354
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 14:39:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjLD-0002eg-6x; Tue, 17 Oct 2023 08:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qsjLB-0002eJ-17
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:38:29 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qsjL9-00073U-JK
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:38:28 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-408382da7f0so870835e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 05:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697546305; x=1698151105; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a+/gkezy10Ls8pDYW/Sj2csBhPv/2izeVZYzpctIFuQ=;
 b=gRDbgVjsvfHqCqBlR2APXkrnFfepZnLjeEE6K4Qux7srACTsRMTg6LGTMax7jjkm/e
 1YOUR3iHjARqPfNrqJsgRGpJQoNKRN5SILjsgWdSPIwgX/n96RPapIHR9m/F6Qs+1NUf
 rAirViFilEbzJeBXrORUlrwhShQiFx83PX9kjUJ7bkPZQry8Id1P3hisqoBKBRzxbAUP
 rwBc+RU3BgV/ngs7xnjh/qT5TUSmxoIi3O4gcC+8o1WF69HD4w3f+kjSbSdTLm0rYgTO
 Ucnb1C4b0HqzDUgFOECXEZEz//tWxU2PsufCQn/dYqp9H10G43XDI7QhKqgZ3gQc/f4m
 AhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697546305; x=1698151105;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a+/gkezy10Ls8pDYW/Sj2csBhPv/2izeVZYzpctIFuQ=;
 b=jQ/0EYelTHQi/obnN1IVpoljR2XaMSOyIXBp06QbPBBNZ/ou3fmhLmU//wrzKLgyvl
 MsKiuk778PnLrSnHMEzPaqMHSRoTZTbT4OR55VvrzT3ypEo3RAs/2Xh6GL5iXL/fSKv3
 5GIyYJlKMJSeB4RnjvsV/G37QP963Hf+gnMcD85Z4FbrulCbP+3PZAxCOpnNBAh4fEQK
 EOBidyDstPVcMODFLiHVpy3nxOCNGJQn5ojgOWLL3jQ2SabKyvB28J8+C9s9lzxEE7OD
 Gzpv4AXWI7+9ZlVDXl6VJE04tDkqijzKBIp4u5DHXLsUZnwafQ+agYsmEHs7GA8gtW/1
 ECcg==
X-Gm-Message-State: AOJu0Yw73DlN9LAr3fnLE/VTrCekJauRF7iEV72BPSkj3WYooTMrKdz+
 VjJSWMltlyxrOB0MpNUGuW0=
X-Google-Smtp-Source: AGHT+IFxFrXXCz1uUzm3BVWxBto2odJL+HFH80jSVPokGAazwNDtxwB0FgUudooL8KN5VTN2JW74Xw==
X-Received: by 2002:a05:6000:137b:b0:321:67d8:c3e7 with SMTP id
 q27-20020a056000137b00b0032167d8c3e7mr1862916wrz.12.1697546305457; 
 Tue, 17 Oct 2023 05:38:25 -0700 (PDT)
Received: from [192.168.13.218] (54-240-197-239.amazon.com. [54.240.197.239])
 by smtp.gmail.com with ESMTPSA id
 x8-20020adfdd88000000b0032da7454ebesm1602697wrl.79.2023.10.17.05.38.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 05:38:23 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <29e91c50-1bd5-4267-b923-98ebb1af283f@xen.org>
Date: Tue, 17 Oct 2023 13:38:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 42/78] hw/i386: add fallthrough pseudo-keyword
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
 <067271cdae96ce1e3e6232d9c7c7b30c8c3941ec.1697186560.git.manos.pitsidianakis@linaro.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <067271cdae96ce1e3e6232d9c7c7b30c8c3941ec.1697186560.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x336.google.com
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

On 13/10/2023 09:46, Emmanouil Pitsidianakis wrote:
> In preparation of raising -Wimplicit-fallthrough to 5, replace all
> fall-through comments with the fallthrough attribute pseudo-keyword.
> 
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   hw/i386/intel_iommu.c    | 4 ++--
>   hw/i386/kvm/xen_evtchn.c | 2 +-

Reviewed-by: Paul Durrant <paul@xen.org>

>   hw/i386/x86.c            | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 


