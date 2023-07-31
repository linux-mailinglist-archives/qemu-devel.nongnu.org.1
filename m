Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 777E176A298
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 23:25:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQaN4-0001bb-Co; Mon, 31 Jul 2023 17:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qQaN2-0001aw-C9
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:24:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qQaN0-0003dJ-QU
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690838641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PTqKIyP+8QjHd2CeZ0ivuYsdhtM4vC5XouYymdmLlRw=;
 b=WYwYO9rQbSZA2zyUZg7wVAjnOzA5v3ILyMh47YsJMgcoeiiqP4lQEKTi4uaatkRgXAUsDa
 BbMndW3RKUnzvn2zxrJNNmwnRZHFKLeGycHYw89zRHGw4nW3XQ2h7tmFnQhw31Z+a7u1RN
 FD2IwdUqED2nv2BRxkwosKdctvUEGaM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677--80uAOsRM5mMwM9I9_4thQ-1; Mon, 31 Jul 2023 17:23:59 -0400
X-MC-Unique: -80uAOsRM5mMwM9I9_4thQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4054266d0beso11542631cf.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 14:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690838639; x=1691443439;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PTqKIyP+8QjHd2CeZ0ivuYsdhtM4vC5XouYymdmLlRw=;
 b=APwRLqKGXRjqfWP87h6BQ/ovW3Ygrn3yLy5P4rNMJiJNeGQ5bLFh2q94XXpqbECKp6
 2Yi0TAS1kD84PxoDZaHH+DDTSayCBxl664b+E4r9SjXcInWttzp7DDoljMBPsad2SypA
 0/GtMwaPSjwTTu6JH/3VpItlsvCTMV23R/8wCcMVCE002ByU18gcc0L0DI+hw9pfglfR
 S4oNAkglGa2hTxuGispiIjbKn4nhBOJLEzGnn0Yv6BhkM7QSFa408uUJWJvBF8a7zltY
 FV65L2JagoOgkiubYWxRxHnsTAuzpmCvvZxNvsthHzOlg0zkNtL3iQfNWTQwybzJ3Mg3
 0CtQ==
X-Gm-Message-State: ABy/qLZAzShpzvaI2em1ddbze20+b84COuYPj/Cw2W8nMR6U7jkfiSbS
 pLhOhpQyeQ3iKOeKWtKfZW29xlPEPSdObOJDgqbWXEXJFDSd7Ox1v12mqb5p5pYWWaDgIW59Jl7
 4qWt2b4Unqsl1LTY=
X-Received: by 2002:ad4:5b83:0:b0:63c:f5fd:d30f with SMTP id
 3-20020ad45b83000000b0063cf5fdd30fmr10962079qvp.1.1690838639013; 
 Mon, 31 Jul 2023 14:23:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEYHqrFI7EZFpBux2VqE7D+hh0uzgUPIcnUR449EgzybpVrYgHBidpiJ/WjnkIRm4YgwKpJcw==
X-Received: by 2002:ad4:5b83:0:b0:63c:f5fd:d30f with SMTP id
 3-20020ad45b83000000b0063cf5fdd30fmr10962059qvp.1.1690838638706; 
 Mon, 31 Jul 2023 14:23:58 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 q14-20020a0cf5ce000000b0063d30c10f1esm4110904qvm.70.2023.07.31.14.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 14:23:58 -0700 (PDT)
Date: Mon, 31 Jul 2023 17:23:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chao Peng <chao.p.peng@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC PATCH 04/19] memory: Introduce memory_region_can_be_private()
Message-ID: <ZMgma0cRi/lkTKSz@x1n>
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
 <20230731162201.271114-5-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230731162201.271114-5-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jul 31, 2023 at 12:21:46PM -0400, Xiaoyao Li wrote:
> +bool memory_region_can_be_private(MemoryRegion *mr)
> +{
> +    return mr->ram_block && mr->ram_block->gmem_fd >= 0;
> +}

This is not really MAP_PRIVATE, am I right?  If so, is there still chance
we rename it (it seems to be also in the kernel proposal all across..)?

I worry it can be very confusing in the future against MAP_PRIVATE /
MAP_SHARED otherwise.

Thanks,

-- 
Peter Xu


