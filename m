Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3F772463A
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:34:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Xif-00054G-GO; Tue, 06 Jun 2023 10:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xie-00053y-2B
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xic-0001F1-FG
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686061889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R9sT329MwhjttK5gufv0DfeLuufewMVeQtMouKLf8OM=;
 b=WPCytQDExu7oAFqw/XOJXyBgOZcWG4p6kVzOWzhSUwdTAmEpxp+ob8j090ufmGWlhXClJM
 ejQDTWTng2xaN0kxgCTb68ElxuzBMn8N+zIKkerRev5RzE3Nmx3spwA9G+xbaU2idmV51K
 ulGEdah+Dv+usI1+vipTEN8IOkK98MU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-uwrfJiYIMsWkimpsYSLlCw-1; Tue, 06 Jun 2023 10:31:28 -0400
X-MC-Unique: uwrfJiYIMsWkimpsYSLlCw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9715654aba1so675455566b.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686061887; x=1688653887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R9sT329MwhjttK5gufv0DfeLuufewMVeQtMouKLf8OM=;
 b=UZv5K1UKdVLPNnpWVYtnuE2CGvHHZAZreMqClTa7XqVJrsLeRehqKM7Qm7hrm3U2DP
 TEdFLRSfgqcvXbYw/UCwDoLt0/exZxzgCH2mrHZGCPX8tj2fcMphvvfcLnhypu5epQpc
 2mk4yv46dXjCoJzT0kK6xx3yckZ8xzBKrDZwpw+/hiXCpG5u7ZoD06baGv52Qa5+b6LD
 JxkoDo8C6/Y1zaYUEFuBQ5wmkd26rj2ANv6npV3WI/eYnPetS3+GvxjCGGJeDCQ5DpDP
 8ZECuTDwMkENdtvzDX1PfNnXV4XOSfiRQWHU4VM67HkD+fsdZUKa2Bt12pu67c2Kx+Ag
 rxRw==
X-Gm-Message-State: AC+VfDwLOpuCBZL+OFnTlSBStq2KN2rDQelT+VNatR5TutJZvYkyL8Nr
 bd36nxrNpngwtBIPtiKgV7qfDQXRQOF0oVWexMUgc5lolnyBKkaEbqXF4q8Maio+1f/FVo02+WO
 I+JvcAKlq0DHKbX1ybQAqmLS480rBak/xGIjJ3jkOyQoxk5YaTJrQLvwkqjzW8JqkrdgP8riOwT
 Q=
X-Received: by 2002:a17:907:6293:b0:932:f88c:c2ff with SMTP id
 nd19-20020a170907629300b00932f88cc2ffmr9632535ejc.34.1686061887342; 
 Tue, 06 Jun 2023 07:31:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4i+jsKriV0b8m1/UZC3qcwf+m+vN5gPUcA02hq6JvRpC6RIU0GlB5Ok2FiXiVpisurh02CpQ==
X-Received: by 2002:a17:907:6293:b0:932:f88c:c2ff with SMTP id
 nd19-20020a170907629300b00932f88cc2ffmr9632512ejc.34.1686061887015; 
 Tue, 06 Jun 2023 07:31:27 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 i15-20020a170906114f00b009545230e682sm5595129eja.91.2023.06.06.07.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 07:31:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/21] meson.build: Group the audio backend entries in a
 separate summary section
Date: Tue,  6 Jun 2023 16:31:01 +0200
Message-Id: <20230606143116.685644-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606143116.685644-1-pbonzini@redhat.com>
References: <20230606143116.685644-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

From: Thomas Huth <thuth@redhat.com>

Let's make it easier for the users to spot audio-related entries
in the summary of the meson output.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230602171832.533739-4-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/meson.build b/meson.build
index b0adf5b4617..97b32e9beb5 100644
--- a/meson.build
+++ b/meson.build
@@ -4251,6 +4251,24 @@ summary_info += {'curses support':    curses}
 summary_info += {'brlapi support':    brlapi}
 summary(summary_info, bool_yn: true, section: 'User interface')
 
+# Audio backends
+summary_info = {}
+if targetos not in ['darwin', 'haiku', 'windows']
+  summary_info += {'OSS support':     oss}
+  summary_info += {'sndio support':   sndio}
+elif targetos == 'darwin'
+  summary_info += {'CoreAudio support': coreaudio}
+elif targetos == 'windows'
+  summary_info += {'DirectSound support': dsound}
+endif
+if targetos == 'linux'
+  summary_info += {'ALSA support':    alsa}
+  summary_info += {'PulseAudio support': pulse}
+endif
+summary_info += {'Pipewire support':  pipewire}
+summary_info += {'JACK support':      jack}
+summary(summary_info, bool_yn: true, section: 'Audio backends')
+
 # Network backends
 summary_info = {}
 if targetos == 'darwin'
@@ -4271,20 +4289,6 @@ summary_info += {'virgl support':     virgl}
 summary_info += {'blkio support':     blkio}
 summary_info += {'curl support':      curl}
 summary_info += {'Multipath support': mpathpersist}
-if targetos not in ['darwin', 'haiku', 'windows']
-  summary_info += {'OSS support':     oss}
-  summary_info += {'sndio support':   sndio}
-elif targetos == 'darwin'
-  summary_info += {'CoreAudio support': coreaudio}
-elif targetos == 'windows'
-  summary_info += {'DirectSound support': dsound}
-endif
-if targetos == 'linux'
-  summary_info += {'ALSA support':    alsa}
-  summary_info += {'PulseAudio support': pulse}
-endif
-summary_info += {'Pipewire support':   pipewire}
-summary_info += {'JACK support':      jack}
 summary_info += {'Linux AIO support': libaio}
 summary_info += {'Linux io_uring support': linux_io_uring}
 summary_info += {'ATTR/XATTR support': libattr}
-- 
2.40.1


