Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C31D1719BEA
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:21:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hFu-0004pT-3J; Thu, 01 Jun 2023 08:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4hFk-0004iR-2l
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:18:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4hFi-0007Wj-80
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685621881;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y1Lcbnstuoh/s8pbif3HHwPXfN1pJEC/Zf1ZwnYWND4=;
 b=BQgOapN6WTVwqaWxGISJIpoKCuSCXECovreztVv8ddNzoXmaX6c6Q0ccknA/kNH6h609Op
 5cOoqR0Zx702qgVnzVodilfCALUzJ/vsKF3twujuapfRF0Qaev/cgntBUC2ffFEXnQRS5H
 uXnqPEQEyywKr0J7M1ErZpzLT3StwIQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-U0QlJHH8OMC-2fcF3DTFBg-1; Thu, 01 Jun 2023 08:17:59 -0400
X-MC-Unique: U0QlJHH8OMC-2fcF3DTFBg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f6f2f18ecbso4975325e9.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 05:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685621872; x=1688213872;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y1Lcbnstuoh/s8pbif3HHwPXfN1pJEC/Zf1ZwnYWND4=;
 b=T0aGZ4mQqRNcyz9YgJU+IcC5RMmbm/9gKoOpzSoO4zkmz/SX5HoA2OUMnw+6jhgNPu
 GTfr0gSJUkqLWYs5qc7llmRJFOq0jeMPAT18LSfSUPDeR5hOsQGpjhDFTAYlrnvOxljH
 qt8HsgLZoxm2gHmtWu0QmPOfNtYHCW2pVgw06EVTBOKCSjkJzCyGAXiXfu44qW1Eg82t
 Sd3fx/caOXulXmKh6yVyY74ed6dx0E6SF40be2KL1C9B8sYZ0N8syI2Hj1qxyt4azB79
 naxHYpARvTqXCUfz+LsbypWng99TJfOUbWTA5mtHKMuHOh9v7MR+/dmOAu36QC29wRYG
 1IuQ==
X-Gm-Message-State: AC+VfDxdY+aFKd/0fzeXJNgreW9Wew5quBe/F+iW7C4BBgMz641EXN5N
 Ap35dCikVeNZslBwmRgE5rqVbZxIJwS0I3wSPKk2bEIFLnIMglwlFDnHa8xCT7Gy/KW/6iaaVEA
 jLOO8nX5WmMqbGjE=
X-Received: by 2002:a7b:c5d4:0:b0:3f6:ffe:9ef1 with SMTP id
 n20-20020a7bc5d4000000b003f60ffe9ef1mr1879894wmk.36.1685621872744; 
 Thu, 01 Jun 2023 05:17:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Y21JtkJn/+vRpL+WrCYlhVMa2qHTiwzBnQkgJn45RikzSRFUfarfOXjYwLLhHd9vIYr7Rcw==
X-Received: by 2002:a7b:c5d4:0:b0:3f6:ffe:9ef1 with SMTP id
 n20-20020a7bc5d4000000b003f60ffe9ef1mr1879873wmk.36.1685621872400; 
 Thu, 01 Jun 2023 05:17:52 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 9-20020a05600c028900b003f60482024fsm2215844wmk.30.2023.06.01.05.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 05:17:51 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Laurent Vivier <lvivier@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 3/9] tests/qtest: get rid of 'qmp_command' helper in
 migration test
In-Reply-To: <20230531132400.1129576-4-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 31 May 2023 14:23:54
 +0100")
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-4-berrange@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 01 Jun 2023 14:17:51 +0200
Message-ID: <87v8g7s7f4.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> This function duplicates logic of qtest_qmp_assert_success_ref
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Much better that the current code.  And as you answer to Thomas, better
messages in case of errors.


