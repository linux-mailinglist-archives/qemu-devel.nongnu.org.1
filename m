Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD5A8245D0
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:08:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQGb-0005Md-2y; Thu, 04 Jan 2024 11:08:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQGZ-0005ME-Bj
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:08:19 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQGW-0007r3-Ua
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:08:19 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-555f581aed9so824270a12.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 08:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704384495; x=1704989295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cDuZ+ZFYtuYIHlX929Wp45cTfCHBpNTDfj/l3L3UOnQ=;
 b=i4aQM/a0WknOOKt2Fx6GyL0AWn0e0lXhDHuKY4PYSlg5CRZPs3medE26kesDIS/sqO
 ZCXwwrYAhicN+DaD+RP3n2t3qCQ03E+nRnd7OV5P1TNjIaGYasEbGGlHURFNIEcIooB2
 1AUo7/hEPmBUVB1MrZ/SidcIMaFUj0Eot+fPE95zNIe0K6rIhTSlxiIXPfV6QV0aiwNO
 J0K5cBxMo62JM+SPkJx+i49TlOJZbpLBY8xJ5M2dsODlWj/wgqhm0r87ZzOtepg3v369
 jktGdoniSRt9VjahtB0IwQdgFXV6KPr7l+B53F6qmhBAhrU0lxXaxNf1CYkdejzhL31f
 rZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704384495; x=1704989295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cDuZ+ZFYtuYIHlX929Wp45cTfCHBpNTDfj/l3L3UOnQ=;
 b=kMMnSAeT2c7p/QGkiRaZgEH2t+eQyMsikg2QW8CNFaWTebTXu5Ilp9rnV0zVsNjgyw
 D1CrbvHWoIP3QD7z8suDK6IsW9ne1++pCec5K4HVZtUiInJdRb3pCnnyu5CJmvpGpc1a
 PUougSagsqkmA9UCHnD/Yxr39YMFWE/Dn5tTNpqfVQxe/Vt39oWEuN1G+Kz1IudX2Es2
 qR+Te1FnCTvkCV5HpDGJxqkjVrx/WceGFYBouEFmDWBw2Hr3OsIF1XEbEYsplPvmQ7S6
 PA9n9PUVg1wg7FbtM4SsHNsuPfU6Xujyt1Sp/OyRe4DLemeyA1RrHZuNpr3ruz+Mjz+5
 Jd3g==
X-Gm-Message-State: AOJu0Yw39Rg9x9xwFsqNGqIbeYr0zTt4aym3CQiRtNKQdNGjgcaHM8QC
 JKgRdCj1CQWRy5ThHSegovjmMLHWHtvVortOKVIBfZ5vN7IR2A==
X-Google-Smtp-Source: AGHT+IHFDD0np3Nds+zZcZP8j+dzG345n1mFAvRRUdSjJpZBNpt+qoXDoNCD57Q7Wb1vwgHhReZ1EQ==
X-Received: by 2002:a50:d48e:0:b0:555:59f:1743 with SMTP id
 s14-20020a50d48e000000b00555059f1743mr502460edi.54.1704384495382; 
 Thu, 04 Jan 2024 08:08:15 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a056402194500b005571c7e4934sm20908edz.93.2024.01.04.08.08.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Jan 2024 08:08:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Xianglai Li <lixianglai@loongson.cn>, Zhiguo Wu <wuzhiguo@loongson.cn>,
 Erik Skultety <eskultet@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH 1/9] scripts/ci: Do not enforce gitlab-runner path
Date: Thu,  4 Jan 2024 17:07:57 +0100
Message-ID: <20240104160805.56856-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240104160805.56856-1-philmd@linaro.org>
References: <20240104160805.56856-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Distributions are not forced to put gitlab-runner binary
in /usr/bin (as long as it is in $PATH).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
---
FWIW this file seems to use legacy options:

TASK [Register the gitlab-runner] *****************************************=
**************************************************************************
task path: /srcqemu/scripts/ci/setup/gitlab-runner.yml:78
changed: [oe2203] =3D> {"changed": true, "cmd": ["gitlab-runner", "register=
", "--non-interactive", "--url", "https://gitlab.com", "--registration-toke=
n", "glrt-FOO_BAR", "--executor", "shell", "--tag-list", "loongarch64,opene=
uler_22.03", "--description", "openEuler 22.03 loongarch64 (Loongson)"], "d=
elta": "0:00:00.955654", "end": "2024-01-04 02:33:23.607766", "msg": "", "r=
c": 0, "start": "2024-01-04 02:33:22.652112", "stderr": "Runtime platform  =
                                \u001b[0;m  arch\u001b[0;m=3Dloong64 os\u00=
1b[0;m=3Dlinux pid\u001b[0;m=3D147134 revision\u001b[0;m=3D436955cb version=
\u001b[0;m=3D16.6.1\nRunning in system-mode.                           \u00=
1b[0;m \n                                                  \u001b[0;m \n\u0=
01b[0;33mWARNING: You have specified an authentication token in the legacy =
parameter --registration-token. This has triggered the 'legacy-compatible r=
egistration process' which has resulted in the following command line param=
eters being ignored: --locked, --access-level, --run-untagged, --maximum-ti=
meout, --paused, --tag-list, and --maintenance-note. For more information, =
see https://docs.gitlab.com/ee/ci/runners/new_creation_workflow.html#change=
s-to-the-gitlab-runner-register-command-syntaxThese parameters and the lega=
cy-compatible registration process will be removed in GitLab Runner 18.0. \=
u001b[0;m \nVerifying runner... is valid                      \u001b[0;m  r=
unner\u001b[0;m=3DkDNtto8nr\nRunner registered successfully. Feel free to s=
tart it, but if it's running already the config should be automatically rel=
oaded!\n\u001b[0;m \nConfiguration (with the authentication token) was save=
d in \"/etc/gitlab-runner/config.toml\"\u001b[0;m ", "stderr_lines": ["Runt=
ime platform                                  \u001b[0;m  arch\u001b[0;m=3D=
loong64 os\u001b[0;m=3Dlinux pid\u001b[0;m=3D147134 revision\u001b[0;m=3D43=
6955cb version\u001b[0;m=3D16.6.1", "Running in system-mode.               =
            \u001b[0;m ", "                                                =
  \u001b[0;m ", "\u001b[0;33mWARNING: You have specified an authentication =
token in the legacy parameter --registration-token. This has triggered the =
'legacy-compatible registration process' which has resulted in the followin=
g command line parameters being ignored: --locked, --access-level, --run-un=
tagged, --maximum-timeout, --paused, --tag-list, and --maintenance-note. Fo=
r more information, see https://docs.gitlab.com/ee/ci/runners/new_creation_=
workflow.html#changes-to-the-gitlab-runner-register-command-syntaxThese par=
ameters and the legacy-compatible registration process will be removed in G=
itLab Runner 18.0. \u001b[0;m ", "Verifying runner... is valid             =
         \u001b[0;m  runner\u001b[0;m=3DkDNtto8nr", "Runner registered succ=
essfully. Feel free to start it, but if it's running already the config sho=
uld be automatically reloaded!", "\u001b[0;m ", "Configuration (with the au=
thentication token) was saved in \"/etc/gitlab-runner/config.toml\"\u001b[0=
;m "], "stdout": "", "stdout_lines": []}
---
 scripts/ci/setup/gitlab-runner.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/ci/setup/gitlab-runner.yml b/scripts/ci/setup/gitlab-r=
unner.yml
index 7bdafab511..48a3ecfe72 100644
--- a/scripts/ci/setup/gitlab-runner.yml
+++ b/scripts/ci/setup/gitlab-runner.yml
@@ -74,18 +74,18 @@
         - ansible_facts['distribution'] =3D=3D 'CentOS'
=20
     - name: Register the gitlab-runner
-      command: "/usr/bin/gitlab-runner register --non-interactive --url {{=
 gitlab_runner_server_url }} --registration-token {{ gitlab_runner_registra=
tion_token }} --executor shell --tag-list {{ ansible_facts[\"architecture\"=
] }},{{ ansible_facts[\"distribution\"]|lower }}_{{ ansible_facts[\"distrib=
ution_version\"] }} --description '{{ ansible_facts[\"distribution\"] }} {{=
 ansible_facts[\"distribution_version\"] }} {{ ansible_facts[\"architecture=
\"] }} ({{ ansible_facts[\"os_family\"] }})'"
+      command: "gitlab-runner register --non-interactive --url {{ gitlab_r=
unner_server_url }} --registration-token {{ gitlab_runner_registration_toke=
n }} --executor shell --tag-list {{ ansible_facts[\"architecture\"] }},{{ a=
nsible_facts[\"distribution\"]|lower }}_{{ ansible_facts[\"distribution_ver=
sion\"] }} --description '{{ ansible_facts[\"distribution\"] }} {{ ansible_=
facts[\"distribution_version\"] }} {{ ansible_facts[\"architecture\"] }} ({=
{ ansible_facts[\"os_family\"] }})'"
=20
     # The secondary runner will still run under the single gitlab-runner s=
ervice
     - name: Register secondary gitlab-runner
-      command: "/usr/bin/gitlab-runner register --non-interactive --url {{=
 gitlab_runner_server_url }} --registration-token {{ gitlab_runner_registra=
tion_token }} --executor shell --tag-list aarch32,{{ ansible_facts[\"distri=
bution\"]|lower }}_{{ ansible_facts[\"distribution_version\"] }} --descript=
ion '{{ ansible_facts[\"distribution\"] }} {{ ansible_facts[\"distribution_=
version\"] }} {{ ansible_facts[\"architecture\"] }} ({{ ansible_facts[\"os_=
family\"] }})'"
+      command: "gitlab-runner register --non-interactive --url {{ gitlab_r=
unner_server_url }} --registration-token {{ gitlab_runner_registration_toke=
n }} --executor shell --tag-list aarch32,{{ ansible_facts[\"distribution\"]=
|lower }}_{{ ansible_facts[\"distribution_version\"] }} --description '{{ a=
nsible_facts[\"distribution\"] }} {{ ansible_facts[\"distribution_version\"=
] }} {{ ansible_facts[\"architecture\"] }} ({{ ansible_facts[\"os_family\"]=
 }})'"
       when:
         - ansible_facts['distribution'] =3D=3D 'Ubuntu'
         - ansible_facts['architecture'] =3D=3D 'aarch64'
         - ansible_facts['distribution_version'] =3D=3D '22.04'
=20
     - name: Install the gitlab-runner service using its own functionality
-      command: "/usr/bin/gitlab-runner install --user gitlab-runner --work=
ing-directory /home/gitlab-runner"
+      command: "gitlab-runner install --user gitlab-runner --working-direc=
tory /home/gitlab-runner"
       register: gitlab_runner_install_service_result
       failed_when: "gitlab_runner_install_service_result.rc !=3D 0 and \"a=
lready exists\" not in gitlab_runner_install_service_result.stderr"
=20
--=20
2.41.0


