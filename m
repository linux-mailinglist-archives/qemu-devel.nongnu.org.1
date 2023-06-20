Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F7D73709D
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:37:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBdP4-0006Yw-AO; Tue, 20 Jun 2023 11:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBdOy-0006Xy-CA
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:36:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBdOv-00074e-OF
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687275372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oJ2WO0IJDMHc+E2qexjnjlTonZjcN34EapkE8KsWAEY=;
 b=E84tydZzwk46H1xawAsnzW/+HB2hlWH5bMtVkU2lYSWWKuz8mZanqVClNSDnq0RpActze+
 w35+obW+uZntLUKiDYCyW8cftY1PNDy7nDLF/pcgiV9mMolQmQfHJyDjnbtUD69eas1F0D
 FnQxmkw6PsG5ZJU5sfW5UimER4NC7Ao=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-38PG67SoMwS_vDOiZlYT1A-1; Tue, 20 Jun 2023 11:35:57 -0400
X-MC-Unique: 38PG67SoMwS_vDOiZlYT1A-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-78f37126806so92495241.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687275353; x=1689867353;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oJ2WO0IJDMHc+E2qexjnjlTonZjcN34EapkE8KsWAEY=;
 b=XB3fxDjGXVvHTDcenr99nEFm45uVf9NcTVxvGYcZTCD0yjKCsquLMCtQib7NAYOho9
 fiB7ZxsHJoYfnZUkh4PEcW1pj2DpJ4+xH+7ZOwdJfHgkJbc4k0ONPmOTNEcbrcMquGZq
 2HOliYg/n+srRD6OBInN7aoiWdKTTZHov0rdkUj+03ZPr/NNYvKKpntNxvjeWDQKeOFc
 LZ2SIAh+y1/C+Fft1JC1XG28dQGyejHqWNoSB8BYgh4n8O4ew9MWv5Jsof0CQSYkFhnD
 v0gdRfcApXY/JxBVtQM0axa6uZYcEuT/dIUATHoGvjrUX2C2UrtXILrpNymmyFpUfAli
 ZZ3w==
X-Gm-Message-State: AC+VfDw7Kto/cHKuygnmaW2ITc8vOItsFbKHhmmbOH1fnT6ItbVrpM4j
 zbpsclXBr/Fa5rcwFdVoCD8c9P2IEJypM4F4P5WHJdd7xul2dpoI7BilwNEYUQFy1Q1udGEQj9o
 7VkJvgo3PdADzz1Q=
X-Received: by 2002:a67:f8c9:0:b0:440:cccb:6652 with SMTP id
 c9-20020a67f8c9000000b00440cccb6652mr700441vsp.3.1687275353353; 
 Tue, 20 Jun 2023 08:35:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7L/i3Weh1jyaqSZ0Xv2DxCIGMvWkjiFC1i3l8Wxq/8ZQkIrgYpzP09QK35TSamWxRUmKvFJg==
X-Received: by 2002:a67:f8c9:0:b0:440:cccb:6652 with SMTP id
 c9-20020a67f8c9000000b00440cccb6652mr700432vsp.3.1687275353094; 
 Tue, 20 Jun 2023 08:35:53 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 gs7-20020a056214226700b006262956aa0fsm1321864qvb.106.2023.06.20.08.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:35:52 -0700 (PDT)
Date: Tue, 20 Jun 2023 11:35:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 14/42] migration-test: test_migrate_start() always return 0
Message-ID: <ZJHHVy7w4Gxama7J@x1n>
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-15-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230608224943.3877-15-quintela@redhat.com>
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

On Fri, Jun 09, 2023 at 12:49:15AM +0200, Juan Quintela wrote:
> So make it return void instead and adjust all callers.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


