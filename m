Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FAC7677F1
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 23:55:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPUxk-00055U-0g; Fri, 28 Jul 2023 17:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qPUxi-00055L-6z
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 17:25:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qPUxg-0000pd-D7
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 17:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690579523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ou7md5uwLIpoQif4+4pIEbuD38nJB39fBTQxrN3HW5k=;
 b=K7DUc2RwJKPcdtQKnX+dBozx3wFS+frooVYJvbRoAudJ7I8OdORUvT1gOK9RhojKnTT512
 LyB2dcOMeU20Re/RGXCQWlopJKHzBuBmo6VpoKDSGNq/CZC3hnkVmrf/eYBImUgtOqccew
 4vrvqGx7LS2Ov58TYzjLfh3VYhEr3do=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-fsGXFcE1PAuq8IfLJdzvtw-1; Fri, 28 Jul 2023 17:25:21 -0400
X-MC-Unique: fsGXFcE1PAuq8IfLJdzvtw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-76c7cffef41so24515085a.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 14:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690579521; x=1691184321;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ou7md5uwLIpoQif4+4pIEbuD38nJB39fBTQxrN3HW5k=;
 b=ctY9YvJtNnkUlUKBTDDnOllARKPKTwmgib/ReuFJNK+P0tySL8RLuM6s9DVMRIhvxo
 FaFE2ojN2fxtWv3J26m+kXncUW7bm03VCAz80cPRHPubQAk6le+KG+ADC/MZD4DPnxr7
 dGctBPwJQ9+NuIi+hwRdyiksv7uW8+Xj54NG2/SbQ9oKIhm4yNyJPCJODcrNN1n/freY
 AKPnPLrGrBX7emIgz1Di13Zp1L2+6rjBXcGFEExFa9fSZiKCDZ+JuAum8Se3xRltz3IR
 hVPRBE9MOTilNidNyG/awD6RPOaRu5CeinuXAJAZMW0mmjmmBG+C8QrGYSxvxuOiIs0D
 RbUw==
X-Gm-Message-State: ABy/qLa1UpWqrNtg08FZ/I2K31hoB6W8emetMZGZZf20KaJB594clzSh
 lU9YAYOWPSkBiniigL4491J0garRECTqFfSjDWaHLI9TdiaUs3/WsMHHMNXfIzpwwR0/p/sHuOl
 Qzt+89mJl2oZZM3E=
X-Received: by 2002:a05:620a:198a:b0:767:ffb:58aa with SMTP id
 bm10-20020a05620a198a00b007670ffb58aamr377568qkb.3.1690579521205; 
 Fri, 28 Jul 2023 14:25:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGrpXZEleiSEj5ENTUB0rPMBfI7ddKxprUn5HxOJgpwX2jrdrIg3FLp+4+GCYl1CLkBfH//0w==
X-Received: by 2002:a05:620a:198a:b0:767:ffb:58aa with SMTP id
 bm10-20020a05620a198a00b007670ffb58aamr377553qkb.3.1690579520962; 
 Fri, 28 Jul 2023 14:25:20 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 pe8-20020a05620a850800b0076c707f3bafsm1345249qkn.94.2023.07.28.14.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 14:25:20 -0700 (PDT)
Date: Fri, 28 Jul 2023 17:25:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: qemu-devel@nongnu.org, David Woodhouse <dwmw2@infradead.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Joao Martins <joao.m.martins@oracle.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v7 4/5] intel_iommu: allow Extended Interrupt Mode when
 using userspace APIC
Message-ID: <ZMQyPbbnyZZ0Foc/@x1n>
References: <20230728144229.49860-1-minhquangbui99@gmail.com>
 <20230728144229.49860-5-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230728144229.49860-5-minhquangbui99@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 28, 2023 at 09:42:28PM +0700, Bui Quang Minh wrote:
> As userspace APIC now supports x2APIC, intel interrupt remapping
> hardware can be set to EIM mode when userspace local APIC is used.
> 
> Suggested-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


