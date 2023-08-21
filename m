Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D971783671
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 01:42:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYEW4-00017R-Da; Mon, 21 Aug 2023 19:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qYEW2-00017F-4r
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 19:40:58 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qYEW0-0005kg-0A
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 19:40:57 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-26b399c6a4aso1956603a91.3
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 16:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692661254; x=1693266054;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=J6hxKzHgi9d4WPNv2P8i1Clv5FBV0aYf+5QTFaoJOKk=;
 b=sk5mVdY6GWxrrtQwwPVcYxuEmc1edYyRX+zvRiMit6+uyM9i726aGsNOQQ0QU1JdD4
 E9Wm8hbt3eTmiOtuXITNI0+TvNOnUOYIh1gIBCYt3s4tQxygxRiu3KwW95uuIcHdY9Mc
 JkAECHU64nuxaGUWHylFCHHGo1z6slbo5CHFoGX3Ff1bgi2y5R3HlBS1+KUhZ4Urb4Dw
 xG1FAbqEMbnPJJhe1pdbVI/hXNoKhg6+tnIEQJyOSmHbYL/5dZPo/N65bwmrRe4J/XjQ
 Cyk5dyRxYqdHELgx9XObPurh0aPW6orSdXRsOAzRjZu77c+RnOLVRbDF4nIRzK7x7Dyy
 hYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692661254; x=1693266054;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6hxKzHgi9d4WPNv2P8i1Clv5FBV0aYf+5QTFaoJOKk=;
 b=jbElsxFhsnGIgX//OlWij0VAsDcoURipqfW7yUgCCZW9sR8aRVMPNlp24bXpz2goeY
 RFFFE1c+0x6OqBP03+nyJMcD7yTLt5RQRiJjvljj9S92SX1vMwy7T18OPeRBIra/GipD
 6BXbu9qjyubd+CK+qdqcUTPCsIkZ5pBX/qTaZsgquuBuPEbmBSC/FXzIVuybuvAJmNNO
 WNqGZeR+fBJrDTmFs3URwKsdr4Zy/0W6lsTZt5Z5lxcZSvZvKLbPJabvH9ADUkhSREJ5
 cvyiClqTvDLmXUVUNHe4Qv8qnQuobafUsoslfyeAACxGOrNQrILby1Js4oFkUUq2lS1a
 q11g==
X-Gm-Message-State: AOJu0Yy5jD5WR6e7vnGMEOa7MCJ+p1Cv/MMjyBmnK7vnEV0a4AyzKegt
 sIrL9aQa6qDRHgGvFT4i/OI=
X-Google-Smtp-Source: AGHT+IHtjBCt8jrVzPeTOBdc8g4jdYrRi/zoCQrAC1is1JU64CShTSGPBmOxlMPvGeI26awApkEH/w==
X-Received: by 2002:a17:90b:906:b0:268:a26:d9ee with SMTP id
 bo6-20020a17090b090600b002680a26d9eemr5094837pjb.46.1692661254519; 
 Mon, 21 Aug 2023 16:40:54 -0700 (PDT)
Received: from localhost ([192.55.55.51]) by smtp.gmail.com with ESMTPSA id
 gl13-20020a17090b120d00b002635db431a0sm6636383pjb.45.2023.08.21.16.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 16:40:54 -0700 (PDT)
Date: Mon, 21 Aug 2023 16:40:52 -0700
From: Isaku Yamahata <isaku.yamahata@gmail.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Eduardo Habkost <eduardo@habkost.net>,
 Laszlo Ersek <lersek@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>, erdemaktas@google.com,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v2 32/58] i386/tdx: Track RAM entries for TDX VM
Message-ID: <20230821234052.GD3642077@ls.amr.corp.intel.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-33-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230818095041.1973309-33-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=isaku.yamahata@gmail.com; helo=mail-pj1-x1029.google.com
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Aug 18, 2023 at 05:50:15AM -0400,
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
> index e9d2888162ce..9b3c427766ef 100644
> --- a/target/i386/kvm/tdx.h
> +++ b/target/i386/kvm/tdx.h
> @@ -15,6 +15,17 @@ typedef struct TdxGuestClass {
>      ConfidentialGuestSupportClass parent_class;
>  } TdxGuestClass;
>  
> +enum TdxRamType{
> +    TDX_RAM_UNACCEPTED,
> +    TDX_RAM_ADDED,
> +};
> +
> +typedef struct TdxRamEntry {
> +    uint64_t address;
> +    uint64_t length;
> +    uint32_t type;

nitpick: enum TdxRamType. and related function arguments.

-- 
Isaku Yamahata <isaku.yamahata@linux.intel.com>

