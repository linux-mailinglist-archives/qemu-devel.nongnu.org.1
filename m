Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B197B9B1E
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 08:34:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoHvY-0004Ia-Hr; Thu, 05 Oct 2023 02:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoHvW-0004IC-VC
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:33:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoHvU-0005wM-Mp
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696487616;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a9yIT+0QNu4Q0GF76YwfnSynQi+VPvWGQglwm0oPTIg=;
 b=Ea23WULmmTNNsFsM4oP0H8qs5ax6bbrY64eA64AX0JbNpoO16fyo/nkM+zcjjnvzUjDFMM
 W5bucVFgGZ/sJdf69KT0ekuak4/rb4TRI6LPUUSl/EMqhzqjeRxhfsfEejelGCj7UYiZSb
 X+bVtThLNX1xOX3R5cUoPa6lMR5C3CA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-jdn5BdZ0PFCv5uaejY0lVw-1; Thu, 05 Oct 2023 02:33:34 -0400
X-MC-Unique: jdn5BdZ0PFCv5uaejY0lVw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-405535740d2so4046165e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 23:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696487613; x=1697092413;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a9yIT+0QNu4Q0GF76YwfnSynQi+VPvWGQglwm0oPTIg=;
 b=ge5gOEu2QREqI9iZHpbDSps7KF3xUFfkv5Xnmo2vHsPACEHUOcgEEAXsskFMYWfjjt
 rS1mPftZFhnaaJJmjtEws9Hj82xBtCo5PWtODlurRUIB0EBGfTts7mU3gtlUuQ3BjKdH
 BPGu7Gvio/QoLQ5z3SnKJINRMWTHhxb0FvPGPvdQ9vcfZuVmy+nbrpmerXDakKxzlG2Z
 fKa5r6PQv3zFyL2ujK1oOKlpc4HTUS3H4QAMWaEPR+f+kTLuwvi/5c3y6u6gHmBXNtZ9
 dbpMw0AjqSI81Cy6YwIBGex8eeQNBsTW18Pr2ehNXwHB0TOihjbOxJm9pRCdUQSehT4P
 ZlcA==
X-Gm-Message-State: AOJu0YzujwLAoNWPo1+UqPCHL3ydZGN0n+pCehcSBxsm62+9SDFIqwM7
 am4XXvjuEihJT3W+4CYD4YAyRAotZwIU/LLJaOcGAkP6Nod8yfOcXXKA2i4oawFh4kPWao3/cNB
 6yRbdoTWnlfWdj7c=
X-Received: by 2002:a05:600c:2113:b0:402:e6a2:c8c7 with SMTP id
 u19-20020a05600c211300b00402e6a2c8c7mr4253988wml.7.1696487613391; 
 Wed, 04 Oct 2023 23:33:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC9OUm9LbDMlTPD62PjHEs6MLc3huN5Wfnz7lvOmXg753WTWGwQ2OA7ahd2dfcoUbhBVLr6g==
X-Received: by 2002:a05:600c:2113:b0:402:e6a2:c8c7 with SMTP id
 u19-20020a05600c211300b00402e6a2c8c7mr4253977wml.7.1696487613075; 
 Wed, 04 Oct 2023 23:33:33 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 19-20020a05600c025300b00401d8181f8bsm3010469wmj.25.2023.10.04.23.33.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 23:33:32 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,  qemu-block@nongnu.org,
 qemu-s390x@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH v2 10/22] qapi: Correct error message for
 'vcpu_dirty_limit' parameter
In-Reply-To: <20231005045041.52649-11-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 5 Oct 2023 06:50:27
 +0200")
References: <20231005045041.52649-1-philmd@linaro.org>
 <20231005045041.52649-11-philmd@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 05 Oct 2023 08:33:31 +0200
Message-ID: <87edi9r32c.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:
> QERR_INVALID_PARAMETER_VALUE is defined as:
>
>   #define QERR_INVALID_PARAMETER_VALUE \
>       "Parameter '%s' expects %s"
>
> The current error is formatted as:
>
>   "Parameter 'vcpu_dirty_limit' expects is invalid, it must greater then =
1 MB/s"
>
> Replace by:
>
>   "Parameter 'vcpu_dirty_limit' is invalid, it must greater then 1 MB/s"
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Juan Quintela <quintela@redhat.com>


