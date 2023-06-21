Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E87F739011
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 21:29:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC3W8-0006SQ-N0; Wed, 21 Jun 2023 15:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC3W7-0006Ru-Dp
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 15:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC3W6-0005SB-1n
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 15:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687375761;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NYtCwRQJblqoQwrMWXPj9B+l8aEnL1UsGsNdVc/rP1Y=;
 b=PkdqGhuotOahChpg4JeJQ14/KdQkhUJBo0OiDIXBxHKR0GPTLZLHPOZNOk7bAcwL+ebemc
 FaEgymuRsdm2EWQ1f8kEik01/4gEhzBcnGoLSJlFikm+D0voRkw9KTMbyRFohQoF4M+wbU
 igf86nfQ94Ll3BHe8oOJGGtd946Bc0A=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-oHtSyrk7P5WfK5Hkn7dREA-1; Wed, 21 Jun 2023 15:29:19 -0400
X-MC-Unique: oHtSyrk7P5WfK5Hkn7dREA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4edc7ab63ccso4634870e87.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 12:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687375758; x=1689967758;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NYtCwRQJblqoQwrMWXPj9B+l8aEnL1UsGsNdVc/rP1Y=;
 b=KZFedfwyoEB+im1i8w1fr06JeZidphe1UmrCbRN67WoRpNYLQvjkOUhurTEuv+kcVP
 z+RW+W5ykZ7WXoue3PRXDh/wi6OylMgBr/9HLW1NLueoCxdkVH9mghUbkUOSOfCvVNFB
 2tjm6bDcdysXK2S1IrdTmeUUUOcKA9BEId1YbDq7V8nmIOeCva6jVNnw4koXImhL0USZ
 oCCRSwvFaPNYlLw0OjJUFwvEN82Sil0vTokVBjI7q3P+tM7oGkOLmGJNgdU00LLNNSq7
 Fb/Qy8jlSZbbZX7fW1zMYTzdiAa2gf25OuMeDfxf2NQC0vuUtWZb8U9myPHPal6rVgV2
 tNCw==
X-Gm-Message-State: AC+VfDyT/ZPVb1dSjqL4dwkNy2lxPnGBFFUgRAL7buGoDlknahymmhvs
 G74VI1H8WIGVnhie0NE/n+ZWd44gWCpxhSLdnDf7hGduhvjTnzqAfpMXa7MbEKXc1+Sx2pDXFx9
 IGAnoM4xaXBbY3zc=
X-Received: by 2002:ac2:464b:0:b0:4f9:127e:55fe with SMTP id
 s11-20020ac2464b000000b004f9127e55femr4080002lfo.17.1687375757947; 
 Wed, 21 Jun 2023 12:29:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7XvqOrBEXDAo2y9GxutBuSg7F4z5AmhCHIZrmXsl5i3gbQsdWiVIJYKkVyAwtPp1j9gKzumg==
X-Received: by 2002:ac2:464b:0:b0:4f9:127e:55fe with SMTP id
 s11-20020ac2464b000000b004f9127e55femr4079982lfo.17.1687375757586; 
 Wed, 21 Jun 2023 12:29:17 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 f20-20020a1c6a14000000b003f8f884ebe5sm5836957wmc.2.2023.06.21.12.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 12:29:16 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,  Eduardo Habkost <eduardo@habkost.net>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  Peter Xu <peterx@redhat.com>,  Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Peter Maydell
 <peter.maydell@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 2/5] include/migration: mark vmstate_register() as a
 legacy function
In-Reply-To: <20230619171437.357374-3-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Mon, 19 Jun 2023 18:14:34 +0100")
References: <20230619171437.357374-1-alex.bennee@linaro.org>
 <20230619171437.357374-3-alex.bennee@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Wed, 21 Jun 2023 21:29:16 +0200
Message-ID: <87o7l8aa2b.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Mention that QOM-ified devices already have support for registering
> the description.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Juan Quintela <quintela@redhat.com>

I really remove that function in a future series (well, I substitute it
with vmstate_register_id() and vmstate_register_any(), but the comment
applies to the new versions also).

Later, Juan.


