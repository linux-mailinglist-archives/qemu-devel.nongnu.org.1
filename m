Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1D37B72C0
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 22:51:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnmME-0006i7-2a; Tue, 03 Oct 2023 16:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qnmLy-0006fF-Ra
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:50:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qnmLw-0005WE-Pa
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696366246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hcQITc5gZReYwZfStA8539JOLzItHMXua7s7aad6DRc=;
 b=MeixBWy5rNBr3weKjEoYmm6bM3YvoeMnXPWaux4uPdmBQ3JaaWXsml25B5qrQed8Mx+vaj
 uISzaBJZhfWVDwIq4dZ119/KSDrrt9Z06PDeGRgbAVbDf5TC3iMq7WaH6YNgADPd5Mvh4P
 OYNy5oNkIbZSOX5F0gXwUA8ayhjBCTc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-IBa7c4pZM1-_2aU6zHFLMQ-1; Tue, 03 Oct 2023 16:50:44 -0400
X-MC-Unique: IBa7c4pZM1-_2aU6zHFLMQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-41810d0d8c2so3720241cf.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 13:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696366244; x=1696971044;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hcQITc5gZReYwZfStA8539JOLzItHMXua7s7aad6DRc=;
 b=hiHe2KHDSTWtLsKifxtGNV5dLH5S//URN07oPkw1vhACw43fsLK16eHh5/AkQbuH40
 HFM64HDe2yzQokyS+7fzIO4qd6LqqwYjNXa89SUwiLCpKgKgbelXH/nGrHa6GG53uZRP
 ZXLOKfae0DRVJSCpjDwq343s8+E+ERs/D4WExFNTvwUIK9xw4swOKSlvvKonD2A5qjvw
 5myeJ+iEro4BWYzywQv1HBX+4JlHgrQ3TJho4tMNlzl23QnGT7XIBLnOfoW5FSUB7qzY
 Pc23z0wKVl4shvSxudG//qH1It0YlAAXHHkEQ+iSWyvjXD+eRW3aRQTq20BiTTvJOlKp
 IAqg==
X-Gm-Message-State: AOJu0Yz+aeBzQidX0d7uT0DB3RwBOHDU2+sG2y2tYKPSZhci5wjCLs0J
 BZ/LDZ9Ie5kSN+NcAoICt9DWrRQCa1QgeDC4sE+u4SCxWQ3CLlj0yQIDLxDKYpkdi6u8RTtdNVT
 CvzEkPG95FfXIOIU=
X-Received: by 2002:a05:6214:21e4:b0:668:e10e:3ca9 with SMTP id
 p4-20020a05621421e400b00668e10e3ca9mr409569qvj.6.1696366244197; 
 Tue, 03 Oct 2023 13:50:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoGDElzav4l4jF6fTR+FodZ0u0lWDJgXwivy/QV1yicV6gFSd2OSk+PKk3sUqDLeARYR1H2g==
X-Received: by 2002:a05:6214:21e4:b0:668:e10e:3ca9 with SMTP id
 p4-20020a05621421e400b00668e10e3ca9mr409551qvj.6.1696366243797; 
 Tue, 03 Oct 2023 13:50:43 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 v4-20020a0c8e04000000b006648514e276sm782949qvb.78.2023.10.03.13.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 13:50:43 -0700 (PDT)
Date: Tue, 3 Oct 2023 16:50:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 1/5] hw/intc/apic: Use ERRP_GUARD() in
 apic_common_realize()
Message-ID: <ZRx+oT/e2ihlDFfi@x1n>
References: <20231003082728.83496-1-philmd@linaro.org>
 <20231003082728.83496-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231003082728.83496-2-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 03, 2023 at 10:27:24AM +0200, Philippe Mathieu-Daudé wrote:
> APICCommonClass::realize() is a DeviceRealize() handler which
> take an Error** parameter and can fail. Do not proceed further
> on failure.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


