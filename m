Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD787DFF72
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 08:39:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyokt-0003A4-MI; Fri, 03 Nov 2023 03:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyokp-00039V-KD
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 03:38:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyokn-000572-9P
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 03:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698997083;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g3OibgvsE8DF+VP2+O3OKF8/Be2n0w+KPm1i2Kvp4x8=;
 b=U6MPFdTrVLr/MikcnyQyjx7pjqbayT+wfI+jISHYrOFddAzLhWL+kOKL01Gk0AZAnNoxq5
 CpCO/L7ZSSn44Co7H/hqcCl/cVaHkeriYOqbm/E+Ztv2DoXOJC0kZBZJSE9qHMvEdEpw4a
 +xHON8VO5k6btk571LXrYI8TQzFiYfQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-yh7MJAJHOiiNs90WXcmdLQ-1; Fri, 03 Nov 2023 03:38:02 -0400
X-MC-Unique: yh7MJAJHOiiNs90WXcmdLQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32d9b520d15so809522f8f.3
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 00:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698997081; x=1699601881;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g3OibgvsE8DF+VP2+O3OKF8/Be2n0w+KPm1i2Kvp4x8=;
 b=smgfO6j1BJgs3FmOW5oFU1tCaK39Wtb2sJxvQOg9hLmt7ToNpgD4Y03Yfm4ALAALrm
 F3enPHPByP+JpULMM5bXiAaSkYKS6thT8IxBechnIX9SS9h8gjMOYsLtdHSfmmm4ikD/
 u0QMTei6zqS+a7Q4UoG8T1Cj/HtKiRI+RrC/IQJu0ReM+v/xGe/hht0CIaCkhIHIk1xt
 LlWPVlnP3JKS7istBUCL0kczROBoEpmREd6PxjjXG+ISD8JOvgc0y78jBqZfBIbRGr7d
 hf5U4TgoqUvK3DlMp77TgeI+weepemqgrr+PjqqpVT69BbGZvTwiFkYuDwzZ5Ik925cF
 wdjA==
X-Gm-Message-State: AOJu0YzHLMvyutQl5homCGlT+WwNhZ3eRLrhZ1kpqVAGNRebRZdEOPCf
 bCC9Q2mOh88CuDl4LyWh9UzNyjrhYQrs04WyWLo3cm0ESS4xc7Bm0wm/YDoHDMnA7ho/624ivC4
 RUpX2LSSnrVCkRgk=
X-Received: by 2002:a05:6000:1f16:b0:31f:afeb:4e7e with SMTP id
 bv22-20020a0560001f1600b0031fafeb4e7emr22503925wrb.37.1698997081159; 
 Fri, 03 Nov 2023 00:38:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTIXS04xg1rS9aVSjhqaa76Tmomt0i6OjJ6ph2zn9p1hZqFhwe+qHXNZq8AQwRp7M6TJ83VQ==
X-Received: by 2002:a05:6000:1f16:b0:31f:afeb:4e7e with SMTP id
 bv22-20020a0560001f1600b0031fafeb4e7emr22503910wrb.37.1698997080839; 
 Fri, 03 Nov 2023 00:38:00 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 e4-20020adfef04000000b0032dde679398sm1188309wro.8.2023.11.03.00.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 00:38:00 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH] migration: Unlock mutex in error case
In-Reply-To: <87ttq447oi.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Thu, 02 Nov 2023 13:16:13 +0000")
References: <87ttq447oi.fsf@draig.linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Fri, 03 Nov 2023 08:37:59 +0100
Message-ID: <87h6m32so8.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Juan Quintela <quintela@redhat.com> writes:
>
>> We were not unlocking bitmap mutex on the error case.
>> Coverity discovered the problem.
>>
>> Fixes: a2326705e5 ("migration: Stop migration immediately in RDMA error =
paths")
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 34724e8fe8..8c4df60f29 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -3040,6 +3040,7 @@ static int ram_save_iterate(QEMUFile *f, void *opa=
que)
>>          ret =3D rdma_registration_start(f, RAM_CONTROL_ROUND);
>>          if (ret < 0) {
>>              qemu_file_set_error(f, ret);
>> +            qemu_mutex_unlock(&rs->bitmap_mutex);
>
> I see the function uses the WITH_RCU_READ_LOCK_GUARD() macro to autofree
> the RCU lock so why not use WITH_QEMU_LOCK_GUARD() instead of manually
> checking the error cases?

You are right.

Changing to that.

Later, Juan.


