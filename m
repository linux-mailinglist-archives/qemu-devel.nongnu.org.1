Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 527FE719C01
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:23:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hL3-00068k-JE; Thu, 01 Jun 2023 08:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4hKq-0005Wi-Ux
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:23:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4hKm-0000JI-MW
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685622195;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xlYre14tlpo8VNvwd+Nt5jCH5DONFu9BrrLOZx4XA/8=;
 b=ODqwaZQKM/xvKJqDNHbn37jpiys1sd77fSLaXtxBDfLLZyx6tWo2CWE0lFt1oCUNCxqVFk
 5yISUKWyrXmMz743u9X87kY7hnLvAFkkQPxALlXr5/4on4t5y08JrgS/zp91mm3bSfkJNW
 gh3KElmR2o+9KKDK8My/cKVfKkskxmY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-Sn0XOqqvN-a7ieazvnZEKg-1; Thu, 01 Jun 2023 08:23:14 -0400
X-MC-Unique: Sn0XOqqvN-a7ieazvnZEKg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30ae4ed92eeso421614f8f.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 05:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685622193; x=1688214193;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xlYre14tlpo8VNvwd+Nt5jCH5DONFu9BrrLOZx4XA/8=;
 b=I7Rj8K0o8nxsqBJHJqeuNxkrTbSFed/InxBRO+JF0c2rzqtPub/0JY8ZuRTjrt+KEY
 wZP6maP7u8RZQmWAqKCWmxLkz6yOmvDOp37PrfiaXZ2MUTuYmutqdmttXhHadnyb/Mbg
 9zDFXjCwKFKZvXNsuF7Tt08w8sFNsRoJINoAMfo3E41n/ti7uhvJ7Y+LDcjj67m5xFeZ
 UO1Rlh06J3tXTgZaI4YtPIs377oytrFCIzUlted0PVcw/7+PqLzGAie+a5oYv931L1rL
 DAJeL11GFRSsTpW8mrE0LivHVpbn6joWUyMfTc7em8kbrZsO73WHvZKAWDbZhr8UaYnt
 fVIA==
X-Gm-Message-State: AC+VfDxXkHk9KJzPb27a6A58mGnwDL/G/IDgwwcg0UUIuTcMed4i3yxU
 Jo2ORlJlaFI8VeN7cEteMxTujeNx9NhRQw5R7fwn5HpudWOd12RBTuWL0UxHMfrcpQVC4/bPIQm
 lXDo1ojWRwg8PlCU=
X-Received: by 2002:a5d:6146:0:b0:307:41a1:a125 with SMTP id
 y6-20020a5d6146000000b0030741a1a125mr1839330wrt.12.1685622193553; 
 Thu, 01 Jun 2023 05:23:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7IRjt+jSFDy29kmSY5mEQ+J770vvPK0o5QSQxnMB9z23HbRZCHF9jeIS/AJ/HEki+vHdHqkQ==
X-Received: by 2002:a5d:6146:0:b0:307:41a1:a125 with SMTP id
 y6-20020a5d6146000000b0030741a1a125mr1839305wrt.12.1685622193218; 
 Thu, 01 Jun 2023 05:23:13 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 k5-20020adff5c5000000b0030af1d87342sm10353852wrp.6.2023.06.01.05.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 05:23:12 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Laurent Vivier <lvivier@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 5/9] tests/qtest: switch to using event callbacks for
 STOP event
In-Reply-To: <20230531132400.1129576-6-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 31 May 2023 14:23:56
 +0100")
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-6-berrange@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 01 Jun 2023 14:23:11 +0200
Message-ID: <87mt1js768.fsf@secure.mitica>
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
> Change the migration test to use the new qtest event callback to watch
> for the stop event. This ensures that we only watch for the STOP event
> on the source QEMU. The previous code would set the single 'got_stop'
> flag when either source or dest QEMU got the STOP event.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

If you agreed with my proposed change to patch 1

> -bool got_stop;
> -
> -static void check_stop_event(QTestState *who)
> +bool migrate_watch_for_stop(QTestState *who, const char *name,
> +                            QDict *event, void *opaque)
>  {
> -    QDict *event =3D qtest_qmp_event_ref(who, "STOP");
> -    if (event) {
> -        got_stop =3D true;
> -        qobject_unref(event);
> +    bool *seen =3D opaque;
> +
> +    if (g_str_equal(name, "STOP")) {
> +        *seen =3D true;

You should
           return true;

here.

Later, Juan.


