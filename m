Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 070267B8141
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 15:47:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo2Dd-0003v2-25; Wed, 04 Oct 2023 09:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo2Da-0003tz-FJ
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:47:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo2DY-0008PT-Hs
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696427231;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xD1q743p4qoLb0i1P/o5mOl+Lhe0Em5H8/cbFPS4tcw=;
 b=jCyjklfM+UcPryjUKBXhcEBCQUexihVEiNPih7NvI2uqrpMH32TjY2VRqMMMCu659zP92B
 t3FqXc/fUNxS/FfA8xJycTYOofqBWFUTLTxv4y/xIHD+LiehoV+FbkMw1B7vOZZ0ohHOj+
 TubdkjXSQN/sKKL10O61MMGEVTmnrSo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-7iq6s_kYO2CSaAhyxXr5Yw-1; Wed, 04 Oct 2023 09:47:10 -0400
X-MC-Unique: 7iq6s_kYO2CSaAhyxXr5Yw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30e4943ca7fso1619062f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 06:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696427228; x=1697032028;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xD1q743p4qoLb0i1P/o5mOl+Lhe0Em5H8/cbFPS4tcw=;
 b=JZpqDH42Kx8hoG6sdvMMbv4SaZFKFxq4RacwI/dREv8xyQZtwmve6t1otIqtVyf3fX
 oWSNZyjF3vPBhBGRlSjFGvQB/eWhchvudlA7J+LZqkLU9P28KF2T8YR5B7pYJvO6+KEa
 /bmBSqTvqeOx5qZpVGe6/Zqik3YfU2BujV0H4NNwQvTM4lbYcc63SzpqrwYNroMpqrRl
 q5ahFNpPOP/Kxm130HLsyWuVF/2us8kIpddAaeM/u1/1eKajrbOYM6jIWfvE3gcLgbAc
 25aFXR5UcZ+6zglOI81G5jJSDwb/PidPru0INrvDUKvimt612EF1we9HKgON5USuKt+S
 7vjg==
X-Gm-Message-State: AOJu0YwWnXNxiGCnTQqQ/QJXW0N0Cm5qD7OHOIKYu9L8oQ6578r1nAry
 dyRDMH2whKyH+gfVq0cJBaQibK/c368MRIBXL2u5xkyBfcBdFll2eKMx81ozPBwnaaj6jHjaerN
 ZTRfr02lCTUFzpgs=
X-Received: by 2002:a5d:6986:0:b0:31a:e972:3601 with SMTP id
 g6-20020a5d6986000000b0031ae9723601mr2292919wru.54.1696427227952; 
 Wed, 04 Oct 2023 06:47:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbpCK5gYR0C5D+NG3t7hVWWCnQiZw5VU+aoVSmhVJzA2didFDf4onHh6YJrolPRnKW53e3fg==
X-Received: by 2002:a5d:6986:0:b0:31a:e972:3601 with SMTP id
 g6-20020a5d6986000000b0031ae9723601mr2292893wru.54.1696427227610; 
 Wed, 04 Oct 2023 06:47:07 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 f16-20020adff590000000b0032326908972sm4054028wro.17.2023.10.04.06.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 06:47:07 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Leonardo Bras <leobras@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Li Zhijian
 <lizhijian@fujitsu.com>,  qemu-s390x@nongnu.org,  Steve Sistare
 <steven.sistare@oracle.com>,  Michael Galaxy <mgalaxy@akamai.com>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PULL 09/11] migration: file URI
In-Reply-To: <87y1gi4i32.fsf@suse.de> (Fabiano Rosas's message of "Wed, 04 Oct
 2023 10:45:21 -0300")
References: <20231004124038.16002-1-quintela@redhat.com>
 <20231004124038.16002-10-quintela@redhat.com> <87y1gi4i32.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 15:47:06 +0200
Message-ID: <87cyxu33fp.fsf@secure.mitica>
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> Juan Quintela <quintela@redhat.com> writes:
>
>> From: Steve Sistare <steven.sistare@oracle.com>
>>
>> Extend the migration URI to support file:<filename>.  This can be used f=
or
>> any migration scenario that does not require a reverse path.  It can be
>> used as an alternative to 'exec:cat > file' in minimized containers that
>> do not contain /bin/sh, and it is easier to use than the fd:<fdname> URI.
>> It can be used in HMP commands, and as a qemu command-line parameter.
>>
>> For best performance, guest ram should be shared and x-ignore-shared
>> should be true, so guest pages are not written to the file, in which case
>> the guest may remain running.  If ram is not so configured, then the user
>> is advised to stop the guest first.  Otherwise, a busy guest may re-dirty
>> the same page, causing it to be appended to the file multiple times,
>> and the file may grow unboundedly.  That issue is being addressed in the
>> "fixed-ram" patch series.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Tested-by: Michael Galaxy <mgalaxy@akamai.com>
>> Reviewed-by: Michael Galaxy <mgalaxy@akamai.com>
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Message-ID: <1694182931-61390-2-git-send-email-steven.sistare@oracle.com>
>
> Juan, FYI we have tests for this feature already reviewed and ready to
> merge:
>
> [PATCH v5 0/6] migration: Test the new "file:" migration
> https://lore.kernel.org/r/20230712190742.22294-1-farosas@suse.de

I searched for URI and didn't found it.

Will got it on next PULL request.

Thanks, Juan.


