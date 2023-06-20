Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA3B736E8C
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 16:21:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBcDR-0005mW-4l; Tue, 20 Jun 2023 10:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBcDJ-0005lF-Ra
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 10:20:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBcDI-0002de-F4
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 10:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687270806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6tTAj4JOcindq3HlHn+ndzNlPZ6L/GPDQvM7YpUBnZk=;
 b=Qva2BK5QFsTOAxBx/SB9dDtTOfVdQkRIpJAfAQ4D8Ah6oPtYfme+05vBPUqVGcm8Zgq+X6
 nTn7D/Adc0HvO2wD0lssOXd2Ae+CmaYvYjdl3XmWTu3O2/w8uQTrLYPbo693Yx8yntDZOi
 o5Lgizd21KzEU5oKRWSpZOiu9zihErE=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-XIa7s7pANAG16RY9GD1OVw-1; Tue, 20 Jun 2023 10:19:42 -0400
X-MC-Unique: XIa7s7pANAG16RY9GD1OVw-1
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-78f1c31f60dso80723241.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 07:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687270774; x=1689862774;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6tTAj4JOcindq3HlHn+ndzNlPZ6L/GPDQvM7YpUBnZk=;
 b=Dxf7psoa4dYOVi9Y4UG2uxqt+qaZC+WWt5VnXMDcJ2mjaMPAGd203BWxGQpnjIdfSQ
 oXp6fAFUxezlVdx2W7X6xWR1lMp4MibuRua1iy3TFDdt2Y/7e2xjxSQSZvVdZnc6oT3M
 5OK6ait+xm3cVpj6gE+V40TO+CI0BXJewKG0YBZSLzgk/cbW1WLvz45XdqakoR3Jt37o
 r5RtafDlzpLLxpyB28v+XJCFeKr5E2OmCa5f5TO08wH+TLOG3Vkjh3hTjMRcUOuto6Hw
 ZGuUCqRuqDEvW1KtmIMLGGXRG6oK1UH0A1OJOutGTKxIl3CxNFZfFrjI7DU3r29K57Cr
 eyyg==
X-Gm-Message-State: AC+VfDw25yK7ayo83yOkxJ+tKySRZ0uGPa7pxDAKbZxHoHhBBsZGL9Pv
 db8Yywtp/lwvv3DyqZwkxKGOFVrGA8/xMxw4aaA2Lw831WuoMRYleRUrrZtfCWaTVLyQnj0UIs4
 7xwYuFLuaetAIRks=
X-Received: by 2002:a05:6122:10cd:b0:471:5239:5976 with SMTP id
 l13-20020a05612210cd00b0047152395976mr4680513vko.1.1687270773442; 
 Tue, 20 Jun 2023 07:19:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Jv2MbFqnzzF+lyyUWXzYjhEAj/7/ZDkqrv1kNeGVN6bBDNHOGnt0mIVS0MFugW7F3hoMzKw==
X-Received: by 2002:a05:6122:10cd:b0:471:5239:5976 with SMTP id
 l13-20020a05612210cd00b0047152395976mr4680495vko.1.1687270773208; 
 Tue, 20 Jun 2023 07:19:33 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 w16-20020a05620a149000b00761fae866c7sm1148715qkj.76.2023.06.20.07.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 07:19:32 -0700 (PDT)
Date: Tue, 20 Jun 2023 10:19:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 2/5] include/migration: mark vmstate_register() as a
 legacy function
Message-ID: <ZJG1c64wBuofsIfB@x1n>
References: <20230619171437.357374-1-alex.bennee@linaro.org>
 <20230619171437.357374-3-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230619171437.357374-3-alex.bennee@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Jun 19, 2023 at 06:14:34PM +0100, Alex Bennée wrote:
> Mention that QOM-ified devices already have support for registering
> the description.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


