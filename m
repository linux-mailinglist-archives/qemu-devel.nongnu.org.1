Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D3D73F5D7
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 09:39:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE3Gc-0004hY-3x; Tue, 27 Jun 2023 03:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qE3GZ-0004h8-9a
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:37:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qE3GX-0002WI-PY
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687851452;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+xgQgUPMb1TaJ3VDoJF0EsH3bpnjRmp0el7s7zL4UX4=;
 b=bX2PBtLa8EUXoNCZLQXTjvvNgofu5uoLvVdaAo7H+njm3RSqv17kVNbap3k4RD7mfvmZcl
 1JOGr9EOychUmPq4Ktr9ie78ZRStyhrnz4vbv16pLtMPRAJ9DZcGEvEETlRianVyi5UjLP
 xPqV+CG74T1dRxgLHEdKS+rJsmye388=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-Tigx0XJaO8OjMYQASNWy0g-1; Tue, 27 Jun 2023 03:37:30 -0400
X-MC-Unique: Tigx0XJaO8OjMYQASNWy0g-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4fab61bb53bso1959227e87.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 00:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687851449; x=1690443449;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+xgQgUPMb1TaJ3VDoJF0EsH3bpnjRmp0el7s7zL4UX4=;
 b=mC2zxistCEcgILm7sCn9cil/mX6dv56fsiX/dgZD+tMCiS/la4KnGVTmYvkKz0T2uz
 K4RZpsM8UUE2XqRd0LD2XeG3kdVdYzaAoq+GZGzX/X7SS2PfI8YovqHBLmuD+G3YjX3z
 jmb5sbkTP4d9paooFK/57PLiDJTP4od3c5s0U042Zj5UF6ooxkEyDKySkV6TH08tcH3W
 yjm1FZfgfdJCu77fKGL4h4QzrwqQTLbk3O8edH2rcsJkOamF/xdpWAzk+RpUsunmXH/3
 20EfBTVUWm7H1dsAJVpQybkaT0r0ghLI8++47v95E4NPxasUIE+zMuwrpcK/PghQ5rAl
 T8DQ==
X-Gm-Message-State: AC+VfDyt6lmBOAZlhlgR+ke7vD+dU46yhYXW8y1Ao0C7qA1QEQBCiqWh
 steZKX/T3ZhHw0a/vvGfnQ+I2Nqq9ARWKbU/qlevQL2JjZiGW8Jtvs9QLfzkCJxJMduVv0Oyj2i
 B++NUUShafxlKcvk=
X-Received: by 2002:a05:6512:684:b0:4f9:b649:23d2 with SMTP id
 t4-20020a056512068400b004f9b64923d2mr5543577lfe.42.1687851449221; 
 Tue, 27 Jun 2023 00:37:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ56LNYs+L4IDklhGDAQMm1B6kmixJT89enn5eAlOd+SuAAFdkhl9Ed5lCARdW7nwyIxUE1GEA==
X-Received: by 2002:a05:6512:684:b0:4f9:b649:23d2 with SMTP id
 t4-20020a056512068400b004f9b64923d2mr5543547lfe.42.1687851448754; 
 Tue, 27 Jun 2023 00:37:28 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 f4-20020a1c6a04000000b003fba2734f1esm1136403wmc.1.2023.06.27.00.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 00:37:27 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,  Qiuhao Li <Qiuhao.Li@outlook.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Stefan Hajnoczi
 <stefanha@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Alexandre
 Iooss <erdnaxe@crans.org>,  Peter Xu <peterx@redhat.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Bin Meng <bmeng.cn@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Beraldo Leal
 <bleal@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Riku Voipio
 <riku.voipio@iki.fi>,  Cleber Rosa <crosa@redhat.com>,  Alexander Bulekov
 <alxndr@bu.edu>,  Radoslaw Biernacki <rad@semihalf.com>,  Bandan Das
 <bsd@redhat.com>,  Leonardo Bras <leobras@redhat.com>,
 qemu-arm@nongnu.org,  Darren Kenny <darren.kenny@oracle.com>,  Wainer dos
 Santos Moschetta <wainersm@redhat.com>,  Laurent Vivier
 <lvivier@redhat.com>
Subject: Re: [PATCH v2 6/6] qemu-keymap: properly check return from
 xkb_keymap_mod_get_index
In-Reply-To: <20230626202516.2507915-7-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?= message of "Mon, 26 Jun 2023 21:25:15 +0100")
References: <20230626202516.2507915-1-alex.bennee@linaro.org>
 <20230626202516.2507915-7-alex.bennee@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 27 Jun 2023 09:37:27 +0200
Message-ID: <87o7l1cq4o.fsf@secure.mitica>
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
> We can return XKB_MOD_INVALID which rightly gets flagged by sanitisers
> as an overly wide shift attempt.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Juan Quintela <quintela@redhat.com>


