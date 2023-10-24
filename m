Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4D57D4DCC
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 12:32:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvEhf-0005Da-HL; Tue, 24 Oct 2023 06:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qvEhc-0005Cr-94
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:32:00 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qvEhW-00056u-As
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:31:59 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-32df66c691dso1511968f8f.3
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 03:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698143512; x=1698748312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Ppf7ZTLomyQ+xSMcIkUzm/9Zg9t4HsI4jD/hNDjyyY=;
 b=klC5oc7uts09YVRnPfMEDoTF1QCeS7OCeU2swSdL9sEBT1e7LlU/urAHtAdA1PbVgf
 ZpaVTOLaQGV6PXqFyuWlMjWYPZH74cMHe8CUvXLcA2i7aASIxmD/bWO6wc4h8T4Rqd6h
 BRjIAQDGVqH7iPoJUYsXGOo8VRJnTX3SxHETeGxolAjALmKhVZovqWNE1APYlDv2u9aC
 t31wdP0WZWvggwjTDyA9yP+Z4gCkU9fbzGakO1dwg8P+9DjGoo6Wa8xzWO5D9HsG2MTB
 YPjc+lY1Nw05uHaOnmw/NX6chxCBLrUi61bCumg0fOxzp4nNVcbK+KD+u+nj7KVbCTM8
 U9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698143512; x=1698748312;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+Ppf7ZTLomyQ+xSMcIkUzm/9Zg9t4HsI4jD/hNDjyyY=;
 b=ln1GCXTHIykKpdiXTnr29DrtKCHpDcosQ7FnK8FyHdOtP+1YN1XKQT/e822VobtW2i
 83aba0kEPXx1BeOt4PMPsfO4Uk3SWXsZkmZMUde60rSjwy056zZZOLyHzeJx3nc5Kfbe
 iU0uk1m6+TcqEfVHZ3Lehvjl5eD0gGteofAm2CBgtMSZm6wZueZAamUODuYp9upg6uB1
 zQXgV+KfNgF1ZQ+KilKwvEPOZ9nT37WoKlMAsBgZ14e80R7pNhZ+V8mExUNOSIeHMByN
 /5SQdk5eZgx/uVwxsxyCUv/kEnoZ7henhECkbigfNVNrYFtX6kbe29oGMLlJtyQU+Xeq
 Qcxw==
X-Gm-Message-State: AOJu0Yx6DGT9t9IGDNTxXX5FVkWDh/ODDX9T+T0qlirfXTgos7YcbQe5
 mL1LZoRZsWdkcNyWY+z0/EIXYg==
X-Google-Smtp-Source: AGHT+IEfVO8TC0ljWRSgMXxN4IQXPSmTdETq6ZWTjsmeZRQiMAg81pEJXctQbJ0DZ02pNAv3if/MpA==
X-Received: by 2002:adf:ed8e:0:b0:32d:9d99:d0a5 with SMTP id
 c14-20020adfed8e000000b0032d9d99d0a5mr9357555wro.5.1698143511690; 
 Tue, 24 Oct 2023 03:31:51 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adfe7d0000000b0032db8f7f378sm9668139wrn.71.2023.10.24.03.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 03:31:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BE7BA1FFBB;
 Tue, 24 Oct 2023 11:31:50 +0100 (BST)
References: <20231023180837.91785-1-titusr@google.com>
 <874jih40a3.fsf@linaro.org>
 <CAMvPwGpXZxyoX1WNypgNCW+Uj+bcVPn99vF71Myx7jn_c2Fjdg@mail.gmail.com>
User-agent: mu4e 1.11.22; emacs 29.1.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Titus Rwantare <titusr@google.com>
Cc: qemu-arm@nongnu.org, minyard@acm.org, philmd@linaro.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/8] PMBus fixes and new functions
Date: Tue, 24 Oct 2023 11:06:21 +0100
In-reply-to: <CAMvPwGpXZxyoX1WNypgNCW+Uj+bcVPn99vF71Myx7jn_c2Fjdg@mail.gmail.com>
Message-ID: <87zg082twp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Titus Rwantare <titusr@google.com> writes:

> On Mon, 23 Oct 2023 at 12:16, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>> You seem to have missed a number of tags from previous postings:
>>
>>   https://qemu.readthedocs.io/en/master/devel/submitting-a-patch.html#pr=
oper-use-of-reviewed-by-tags-can-aid-review
>>
>> (although I notice we only mention Reviewed-by in the docs)
>>
>> You can use a tool like b4 to apply a series and collect the tags. It
>> will also collect the Message-Id's which are also useful.
>>
>> Once you've fixed up your tags I think as the maintainer you can submit
>> a pull request.
>>
>> --
>> Alex Benn=C3=A9e
>> Virtualisation Tech Lead @ Linaro
>
> Thanks for the tip about b4, I spent some time getting to grips with
> it and it's a huge timesaver.
> I haven't quite figured out how to get it to produce and send a signed
> pull request, but I don't need that just yet.

A pull request is really just a GPG signed tag that you push to a repo.
You can use the existing git tooling to create the cover letter for it.

I've included my exact steps at the end of the email but really it comes
down to:

  git tag --sign your-pr-tag
  git push your-pr-tag
  git format-patch <series details>
  git request-pull origin/master your_repo_details your-pr-tag

and finally

  git send-email

My personal exact steps are integrated with my editor but are:

1 Create a branch (optional)
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90

  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80
  =E2=94=82 git fetch origin
  =E2=94=82 branch=3D"pr/$(date +%d%m%y)-${series}-${version}"
  =E2=94=82 if test -z "$prefix" ; then
  =E2=94=82     git checkout -b $branch origin/master
  =E2=94=82 else
  =E2=94=82     git checkout -b $branch HEAD
  =E2=94=82 fi
  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80


2 Apply patches from mailing list
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90

  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80
  =E2=94=82 if test -z $prefix; then
  =E2=94=82     mkdir -p "${series}.patches"
  =E2=94=82     b4 am -S -t -o "${series}.patches" "${id}"
  =E2=94=82 else
  =E2=94=82     echo "Built tree by hand"
  =E2=94=82 fi
  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80

  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80
  =E2=94=82 if test -z $prefix; then
  =E2=94=82     git am ${series}.patches/*.mbx
  =E2=94=82     rm -rf ${series}.patches
  =E2=94=82 else
  =E2=94=82     git log --oneline origin/master..
  =E2=94=82 fi
  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80


3 Check if we are missing any review/comments or tags
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90


4 Check for unreviewed patches
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90


5 Check all sign-offs are there
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90


6 Check we have only 1 Message-Id per commit
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90


7 Check commits are good
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90

  We need to ensure we have added our signoff and there is no =E2=80=94 eph=
emera
  left from commit history.

  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80
  =E2=94=82 errors=3D0
  =E2=94=82 commits=3D0
  =E2=94=82 while read rev; do
  =E2=94=82     author=3D$(git show -s --format=3D'%an <%ae>' $rev)
  =E2=94=82     body=3D$(git show -s --format=3D'%B' $rev)
  =E2=94=82     title=3D$(git show -s --format=3D'%s' $rev)
  =E2=94=82=20
  =E2=94=82     # Check for Author signoff
  =E2=94=82     if ! grep -q "^Signed-off-by: $author" <<< "$body"; then
  =E2=94=82         errors=3D$((errors+1))
  =E2=94=82         echo $(git log -1 --pretty=3Dformat:"missing author sig=
noff - %h - %an: %s" $rev)
  =E2=94=82     fi
  =E2=94=82=20
  =E2=94=82     # Check for my signoff (fix for quotes)
  =E2=94=82     if ! grep -q "^Signed-off-by: $signoff" <<< "$body"; then
  =E2=94=82         errors=3D$((errors+1))
  =E2=94=82         echo $(git log -1 --pretty=3Dformat:"missing my signoff=
 - %h - %an: %s" $rev)
  =E2=94=82     fi
  =E2=94=82=20
  =E2=94=82     if ! grep -q "^Message-Id: " <<< "$body"; then
  =E2=94=82         errors=3D$((errors+1))
  =E2=94=82         echo $(git log -1 --pretty=3Dformat:"missing message id=
 - %h - %an: %s" $rev)
  =E2=94=82     fi
  =E2=94=82=20
  =E2=94=82     # check for unreviewed patches for patches I authored
  =E2=94=82     if [ "$author" =3D "$signoff" ]; then
  =E2=94=82         if ! grep -q "^Reviewed-by:" <<< "$body"; then
  =E2=94=82             echo $(git log -1 --pretty=3Dformat:"unreviewed - %=
h - %an: %s" $rev)
  =E2=94=82         fi
  =E2=94=82     fi
  =E2=94=82=20
  =E2=94=82     # Check for stray Based-on tags
  =E2=94=82     if grep -q "^Based-on: " <<< "$body"; then
  =E2=94=82         errors=3D$((errors+1))
  =E2=94=82         echo $(git log -1 --pretty=3Dformat:"has based-on tag -=
 %h - %an: %s" $rev)
  =E2=94=82     fi
  =E2=94=82=20
  =E2=94=82     # Check for stray history
  =E2=94=82     if grep -q "^--" <<< "$body"; then
  =E2=94=82         errors=3D$((errors+1))
  =E2=94=82         echo $(git log -1 --pretty=3Dformat:"has commit history=
 - %h - %an: %s" $rev)
  =E2=94=82     fi
  =E2=94=82=20
  =E2=94=82     commits=3D$((commits+1))
  =E2=94=82 done < <(git rev-list "origin/master..HEAD")
  =E2=94=82=20
  =E2=94=82 echo "Found $errors errors over $commits commits"
  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80


8 Preparing a QEMU Pull Request
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90

  We have two properties here, tversion for the tag and pversion for the
  iteration of the PULL. This is to account for re-rolls where we detect
  and issue after tagging but before we send the PR itself.

  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80
  =E2=94=82 (let ((tag (format
  =E2=94=82             "pull-%s-%s-%d"
  =E2=94=82             series
  =E2=94=82             (format-time-string "%d%m%y")
  =E2=94=82             tversion)))
  =E2=94=82   (magit-tag-create tag "HEAD" "--sign")
  =E2=94=82   tag)
  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80

  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80
  =E2=94=82 set -e
  =E2=94=82 tag=3D$(git describe)
  =E2=94=82 git push github $tag
  =E2=94=82 if test -z $prefix; then
  =E2=94=82     git push-ci-now gitlab $tag
  =E2=94=82 else
  =E2=94=82     git push-ci gitlab $tag
  =E2=94=82 fi
  =E2=94=82 echo "pushed $tag"
  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80

  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80
  =E2=94=82 (if (=3D 1 pversion)
  =E2=94=82     "PULL"
  =E2=94=82   (format "PULL v%d" pversion))
  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80

  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80
  =E2=94=82 if [ -d "${series}.pull" ]; then
  =E2=94=82   rm -rf ${series}.pull
  =E2=94=82 fi
  =E2=94=82 git format-patch --subject-prefix=3D"$subjprefix" --cover-lette=
r origin/master..HEAD -p -o ${series}.pull
  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80

  You can use the $pull macro to fill in the details


9 And send the pull request
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90

  Using the prefix will limit the send to just the cover letter, useful
  for v2+ pull requests

  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80
  =E2=94=82 if test -z "$prefix" ; then
  =E2=94=82   git send-email --confirm=3Dnever --dry-run --quiet ${mailto} =
${series}.pull/*
  =E2=94=82 else
  =E2=94=82   git send-email --confirm=3Dnever --dry-run --quiet ${mailto} =
${series}.pull/0000*
  =E2=94=82 fi
  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80

  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80
  =E2=94=82 if test -z "$prefix" ; then
  =E2=94=82   git send-email --confirm=3Dnever --quiet ${mailto} ${series}.=
pull/*
  =E2=94=82 else
  =E2=94=82   git send-email --confirm=3Dnever --quiet ${mailto} ${series}.=
pull/0000*
  =E2=94=82 fi
  =E2=94=82 rm -rf ${series}.pull
  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

