Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 640FB7F31D6
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 16:03:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5SGr-0000Ov-6l; Tue, 21 Nov 2023 10:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r5SGp-0000Ob-ET
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:02:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r5SGl-0005Br-Bi
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:02:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700578949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xj6bOe15SjEXGuEeQ7OcNnEF7Df77Zf9Da3M1Rgxc+g=;
 b=hoL55GSl9253Qp4qmLMIbh5yVvYiw0khqwj1OLB5UJbs8aq4he36eMSIikP8W6sfTw/rXw
 Op0MlxFcv6hD70buWWfVbC4QltqW+tjKT/jALH995s1B4i6RPlXZOf0IhYQ3dQClYH75Y2
 HwDyl5tprkcfQJNHrJy4Q1NFfNHOR9E=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-tXeBtz_zOHKTdkMXup00iQ-1; Tue, 21 Nov 2023 10:02:26 -0500
X-MC-Unique: tXeBtz_zOHKTdkMXup00iQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66d7b75c854so16164556d6.1
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 07:02:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700578945; x=1701183745;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xj6bOe15SjEXGuEeQ7OcNnEF7Df77Zf9Da3M1Rgxc+g=;
 b=OsUQGDUzXXloWvmeenYQzx5kqpsYrdub77Oruw4cZiseH6SGSRqQjmwdL809H/wbhV
 POPOAit1JyCo5xPecZfLwy2vfUd1MA4aWPqep+xEYNCpqGEBLMmb9FFuFDxl/9UYQr9Z
 kyU2s8S70os00GZAEJwb3nV0CUHlLdPu+5UvcGav0mZ0FBqd8y1z/Hz5IkmE49KafwSv
 yAnekjY+LUzOkv0XFxYf7RstcgZoJuuiq9Wdi7pTleU6cPE9VHt0M15Pn5aroI85trfn
 WJPXa70ild5+M97XqIfoj+uw0pGmyNLzpode6QYf0cykGVTm2hI1CtDaKUxbZgvafEg/
 45mQ==
X-Gm-Message-State: AOJu0Yx/E8GfO3o2TCPbw/oJ//tK8tG70kUn6/qNOsvaCOizMC9TEuAw
 5HOiW0wW5oJGq5hCEv623RZ9m6+PhOEPSw9U4FimD/0lAOLlTZzAavpG3QbA/aYZOS8sXPpU0qN
 erzAfnhFlWaOjoY8=
X-Received: by 2002:a0c:f98e:0:b0:671:9945:7a36 with SMTP id
 t14-20020a0cf98e000000b0067199457a36mr10875021qvn.1.1700578945186; 
 Tue, 21 Nov 2023 07:02:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOTqrDv8VvRkStwUwPICnX34veGddotE6HxCy8v9/sR6levKH+LgnKCXl6ITKcLCcczQfx9w==
X-Received: by 2002:a0c:f98e:0:b0:671:9945:7a36 with SMTP id
 t14-20020a0cf98e000000b0067199457a36mr10874986qvn.1.1700578944867; 
 Tue, 21 Nov 2023 07:02:24 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 dx5-20020a05620a608500b0076cc4610d0asm3683364qkb.85.2023.11.21.07.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 07:02:20 -0800 (PST)
Date: Tue, 21 Nov 2023 10:02:11 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH-for-9.0 11/25] memory: Have
 memory_region_init_resizeable_ram() return a boolean
Message-ID: <ZVzGc-jGpzYS5U7l@x1n>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-12-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120213301.24349-12-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Nov 20, 2023 at 10:32:45PM +0100, Philippe Mathieu-Daudé wrote:
> Following the example documented since commit e3fe3988d7 ("error:
> Document Error API usage rules"), have cpu_exec_realizefn()

same

> return a boolean indicating whether an error is set or not.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


